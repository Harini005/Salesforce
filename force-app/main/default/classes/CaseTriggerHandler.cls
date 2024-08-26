public with sharing class CaseTriggerHandler {
  public static Map<String, String> ratingDetails = new Map<String, String>{
    'Hot' => 'High',
    'Cold' => 'Low',
    'Warm' => 'Medium'
  };
  public static void setPriority() {
    for (Case record : [SELECT Priority, Account.Rating, AccountId FROM Case WHERE AccountId != NULL]) {
      record.Priority = ratingDetails.get(record.Account.Rating);
    }
  }
  
  public static void onAfterUpdate(){
    Map<Id,Case> newMap = (Map<Id,Case>) Trigger.newMap;
    Map<Id,Case> oldMap = (Map<Id,Case>) Trigger.oldMap;
    Map<Id,String> accountIdsToCaseNumber = new Map<Id,String>();
    for(Case record : newMap.values()){
      if(record.AccountId != oldMap.get(record.Id).AccountId){
        accountIdsToCaseNumber.put(record.AccountId , record.CaseNumber);
      }
    }
    if(accountIdsToCaseNumber.isEmpty()){
      return;
    }
    updateLatestCaseOnAccount(accountIdsToCaseNumber);
  }
  
  public static void updateLatestCaseOnAccount(){
    List<case> records = (List<case>) Trigger.new;
    List<Account> accounts = new List<Account>();
    for(case record : records){
      if(String.isNotBlank(record.AccountId)){
        accounts.add(new Account(Id=record.AccountId , Latest_Case_number__c = record.CaseNumber));
      }
    }
    update accounts;
  }
  
  public static void updateLatestCaseOnAccount(Map<Id,String> accountIdsToCaseNumber){
    List<Account> accountsById = new List<Account>([SELECT Id,Latest_Case_number__c from Account where Id IN :accountIdsToCaseNumber.keySet()]);
    List<Account> accounts = new List<Account>();
    for(Account record : accountsById){
      if(String.isBlank(record.Latest_Case_number__c)){
        accounts.add(new Account(Id=record.Id , Latest_Case_number__c = accountIdsToCaseNumber.get(record.Id)));
        return;
      }
      if(Integer.valueOf(record.Latest_Case_number__c) < Integer.valueOf(accountIdsToCaseNumber.get(record.Id))){
        accounts.add(new Account(Id=record.Id , Latest_Case_number__c = accountIdsToCaseNumber.get(record.Id)));
      }
    }
    update accounts;
  }
}