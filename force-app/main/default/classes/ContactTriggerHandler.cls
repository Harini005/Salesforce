/**
 * @description : Get the Details of the Parent Record Without using For Loop
 * @Credentials : harinigovindarajan005@all.com
 */
public with sharing class ContactTriggerHandler {
  public static void beforeInsert(List<Contact> newRecords) {
    validatePrimaryContact(Trigger.new);
  }
  
  public static void onBeforeUpdate(){
    Map<Id,Contact> newMap = (Map<Id,Contact>) Trigger.newMap;
    Map<Id,Contact> oldMap = (Map<Id,Contact>) Trigger.oldMap;
    List<Contact> records = new List<Contact>();
    for(Contact record : newMap.values()){
      if(oldMap.get(record.Id).Primary_Contact__c != record.Primary_Contact__c){
        records.add(record);
      }
    }
    if(records.isEmpty()){
      return;
    }
    validatePrimaryContact(records);
  }
  
  public static void preventDuplicateContact(){
    List<Contact> newContacts = (List<Contact>)Trigger.new;
    Map<Id,Contact> oldMap = (Map<Id,Contact>) Trigger.oldMap;
    Set<String> recordMatch = new Set<String>();
    for(Contact record : newContacts){
      recordMatch.add(record.Email);
      recordMatch.add(record.Phone);
    }
    recordMatch.remove(null);
    if(recordMatch.isEmpty()){
      return;
    }
    List<Contact> matches = [SELECT Id,Email,Phone from Contact where (Email IN :recordMatch OR Phone IN : recordMatch) AND Id NOT IN :oldMap.keySet()];
    
    if(Matches.isEmpty()){
      return;
    }
    Map<String,Contact> contactMatches = new Map<String,Contact>();
    for(Contact match : matches){
      contactMatches.put(match.Email , match);
      contactMatches.put(match.Phone , match);
    }
    
    for(Contact record : newContacts){
      if(contactMatches.containsKey(record.Email) || contactMatches.containsKey(record.Phone)){
        record.addError('Duplicate record found. Please change the Values');
      }
    }
  }
  
  public static void onAfterUpdate(){
    Map<Id,Contact> newMap = (Map<Id,Contact>) Trigger.newMap;
    Map<Id,Contact> oldMap = (Map<Id,Contact>) Trigger.oldMap;
    List<Contact> contacts = new List<Contact>();
    for(Contact con : newMap.values()){
      if(oldMap.containsKey(con.Id) && con.AccountId != oldMap.get(con.Id).AccountId){
        contacts.add(oldMap.get(con.Id));
      }
    }
    if(contacts.isEmpty()){
      return;
    }
    updateTotalContactonAccount(contacts);
  }
  
  public static void updateTotalContactonAccount(List<Contact> records){
    List<Id> accountIds = new List<Id>();
    for(Contact record : records){
      if(String.isNotBlank(record.AccountId)){
        accountIds.add(record.AccountId);
      }
    }
    
    List<Account> accounts = [SELECT Id,(SELECT Id from Contacts) from Account where Id IN :accountIds];
    List<Account> accountsToUpdate = new List<Account>();
    for(Account account : accounts){
      accountsToUpdate.add(new Account(Id = account.Id , Total_Number_Of_Contacts__c = account.contacts.size()));
    }
    update accountsToUpdate;
  }
  
  public static void validatePrimaryContact(List<Contact> records){
    List<Id> accountIds = new List<Id>();
    for(Contact record : records){
      if(String.isNotBlank(record.AccountId) ){
        accountIds.add(record.AccountId);
      }
    }
    if(accountIds.isEmpty()){
      return;
    }
    Map<Id,Account> accounts = new Map<Id,Account>([SELECT Id,(SELECT Id from Contacts where Primary_Contact__c = true) from Account where Id IN :accountIds]);
    for(Contact contact : records){
      if(accounts.containsKey(contact.AccountId)){
        if(accounts.get(contact.AccountId).Contacts.isEmpty()){
          contact.Primary_Contact__c = true;
          continue;
        }
        if(contact.Primary_Contact__c){
          contact.addError('Primary Contact exsists for the associated Account.');
        }
      }
    }
  }
  
  public static void createContactRelationship(){
    Map<Id,Contact> newMap = (Map<Id,Contact>) Trigger.newMap;
    Map<Id,Contact> oldMap = (Map<Id,Contact>) Trigger.oldMap ?? new Map<Id,Contact>();
    List<Contact_RelationShip__c> contactRelationShips = new List<Contact_RelationShip__c>();
    for(Contact record : newMap.values()){
      if((!oldMap.isEmpty() && record.Contact_RelationShip__C&& oldMap.get(record.Id).Contact_RelationShip__c != record.Contact_RelationShip__c) || record.contact_RelationShip__C){
        contactRelationShips.add(new Contact_RelationShip__C(Contact__c = record.Id));
      }
    }
    insert contactRelationShips;
  }
  
}