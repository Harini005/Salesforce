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
}