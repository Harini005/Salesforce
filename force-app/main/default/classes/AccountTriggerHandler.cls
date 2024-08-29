public with sharing class AccountTriggerHandler {
  public static void onBeforeInsert() {
    List<Contact> relatedContacts = new List<Contact>();
    RegionManagerUtility utility = RegionManagerUtility.getInstance();
    
    for (Account record : (List<Account>) Trigger.New) {
      record.Region_Manager__c = utility.responseMap.get(record.Region__c);
    }
    
    insert relatedContacts;
  }
  
  public static void onBeforeUpdate() {
    Map<Id, Account> oldMap = (Map<Id, Account>) Trigger.oldMap;
    Map<Id, Account> newMap = (Map<Id, Account>) Trigger.newMap;
    RegionManagerUtility utility = RegionManagerUtility.getInstance();
    for (Account record : newMap.values()) {
      if (oldMap.containsKey(record.Id) && oldMap.get(record.Id).Region__c != record.Region__c) {
        record.Region_Manager__c = utility.responseMap.get(record.Region__c);
      }
    }
  }
  
  public static void onAfterInsert() {
    List<Account> records = (List<Account>) Trigger.new;
    List<Contact> relatedContacts = new List<Contact>();
    
    for (Account record : records) {
      if(String.isNotBlank(record.Phone)){
        Contact relatedContact = new ContactBuilder()
          .setAccountId(record.Id)
          .setLastName(record.Name)
          .setEmail(record.Name.replaceAll(' ', '') + '@all.com')
          .setPhone(record.phone)
          .build();
        relatedContacts.add(relatedContact);
      }
    }
    
    insert relatedContacts;
  }
  
  //Create a field on Account Named (Client Opportunity lookup to Opportunity). Once an Account is inserted an opportunity will create with the name of the Account and that Opportunity will be the Client Opportunity on the Account.
  public static void createClientOpportunity(Map<Id,Account> newMap){
    newMap = new Map<Id , Account>([SELECT Id,Name, Client_Opportunity__c from Account WHERE Id IN :newMap.keySet()]);
    Map<Id,Opportunity> accountIdToOpportunity = new Map<Id,Opportunity>();
    for(Account record : newMap.values()){
      if(String.isBlank(record.Client_Opportunity__c)){
        Opportunity opp = new Opportunity(Name= record.Name+' Deal', StageName='Prospecting', CloseDate=System.Today()+100);
        accountIdToOpportunity.put(record.Id , opp);
      }
    }
    
    if(accountIdToOpportunity.isEmpty()){
      return;
    }
    
    insert accountIdToOpportunity.values();
    List<Account> accounts = new List<Account>();
    for(Id accountId : accountIdToOpportunity.keySet()){
      accounts.add(new Account(Id=accountId , client_Opportunity__c=accountIdToOpportunity.get(accountId).Id));
    }
    update accounts;
    
    
  }
  
  //Send Email to Owner when Annual Revenue crosses 50k within 30days.
  public static void sendEmailToOwner(){
    List<Account> accounts = (List<Account>) Trigger.new;
    Map<Id,Account> newMap = (Map<Id,Account>) Trigger.newMap;
    Map<Id,Account> oldMap = (Map<Id,Account>) Trigger.oldMap;
    List<Messaging.SingleEmailMessage> emailsToOwner = new List<Messaging.SingleEmailMessage>();
    List<AccountHistory> accountHistories = [SELECT createdDate,AccountId from AccountHistory where AccountId IN :accounts AND Field = 'AnnualRevenue' order By createdDate];
    Map<Id,List<AccountHistory>> accountIdToHistory = new Map<Id,List<AccountHistory>>();
    for(AccountHistory accountHistory : accountHistories){
      if(!accountIdToHistory.containsKey(accountHistory.AccountId)){
        accountIdToHistory.put(accountHistory.AccountId , new List<AccountHistory>());
      }
      accountIdToHistory.get(accountHistory.AccountId).add(accountHistory);
    }
    for(Account account : [SELECT Id,AnnualRevenue,Owner.Email from Account where Id In :accounts]){
      if(account.AnnualRevenue > 50000 && newMap.get(account.Id).AnnualRevenue != oldMap.get(account.Id).AnnualRevenue){
        if(!accountIdToHistory.containsKey(account.Id)){
          emailsToOwner.add(emailContent(account.OwnerId));
        }
        else{
          Date startDay = accountIdToHistory.get(account.Id)[0].createdDate.date();
          Date endDay = accountIdToHistory.get(account.Id)[accountIdToHistory.get(account.Id).size()-1].createdDate.date();
          if(startDay.daysBetween(endDay) < 30){
            emailsToOwner.add(emailContent(account.owner.Email));
          }
        }
      }
    }
    
    Messaging.SendEmailResult[] results = Messaging.sendEmail(emailsToOwner);
  }
  
  public static Messaging.SingleEmailMessage emailContent(String OwnerEmail){
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setSubject('Annual Revenue crossed 50K');
    email.setPlainTextBody('Dear Owner!!! your company\'s Annual Revenue crossed 50K within 30 days. ' );
    email.setToAddresses(new List<String>{OwnerEmail});
    return email;
  }
  
  public static void setSalesRep(){
    List<Account> accounts = (List<Account>)Trigger.new;
    Map<Id,Account> newMap = (Map<Id,Account>) Trigger.newMap;
    Map<Id,Account> oldMap = (Map<Id,Account>) Trigger.oldMap;
    Set<Id> ownerIds = new Set<Id>();
    for(Account record : accounts){
      ownerIds.add(record.ownerId);
    }
    if(ownerIds.isEmpty()){
      return;
    }
    Map<Id,User> owners = new Map<Id,User>([Select Id,Name from User Where Id IN :ownerIds]);
    for(Account account : accounts){
      if(String.isBlank(account.Sales_Rep__c)){
        account.Sales_Rep__c = owners.get(account.OwnerId).Name;
        continue;
      }
      if(newMap?.containsKey(account.Id) && newMap.get(account.Id).OwnerId != oldMap.get(account.Id).OwnerId){
        account.Sales_Rep__c = owners.get(account.OwnerId).Name;
      }
      
    }
  }
  
  public static void updateOwnerOnContact(){
    Map<Id,Account> newMap = (Map<Id,Account>)Trigger.newMap;
    Map<Id,Account> oldMap = (Map<Id,Account>)Trigger.oldMap;
    Map<Id,Id> accountIdToOwnerId = new Map<Id,Id>();
    for(Account acc : newMap.values()){
      if(oldMap.get(acc.Id).OwnerId != acc.OwnerId){
        accountIdToOwnerId.put(acc.Id , acc.ownerId);
      }
    }
    if(accountIdToOwnerId.isEmpty()){
      return;
    }
    List<Contact> contacts = [SELECT Id,AccountId,OwnerId from Contact Where AccountId IN :accountIdToOwnerId.keySet()];
    List<Contact> contactsToUpdate = new List<Contact>();
    for(Contact contact : contacts){
      contact.OwnerId = accountIdToOwnerId.get(contact.AccountId);
      contactsToUpdate.add(contact);
    }
    if(contactsToUpdate.isEmpty()){
      return;
    }
    update contactsToUpdate;
  }
  
  public static void updateContactOwner(){
    Map<Id,Account> oldMap = (Map<Id,Account>) Trigger.oldMap;
    Map<Id,Account> newMap = (Map<Id,Account>) Trigger.newMap;
    List<Contact> contacts = new List<Contact>();
    List<Account> accountContacts = [SELECT Id,OwnerId ,(SELECT Id,ownerId from Contacts) from Account where Id IN :newMap.values()];
    for(Account record : accountContacts){
      if(oldMap.get(record.Id).OwnerId != record.OwnerId){
        for(Contact con : record.Contacts){
          contacts.add(new contact(Id=con.Id , OwnerId =  oldMap.get(record.Id).ownerId ));
        }
      }
    }
    update contacts;
  }
}