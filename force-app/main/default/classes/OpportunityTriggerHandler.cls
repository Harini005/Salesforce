public with sharing class OpportunityTriggerHandler {
  public static final Decimal AMOUNT_LIMIT = 5000;
  public static void onBeforeInsert() {
    for (Opportunity record : (List<Opportunity>) Trigger.new) {
      if (record.Amount > AMOUNT_LIMIT) {
        amountChecker();
      }
    }
  }
  
  public static void onBeforeUpdate() {
    Map<Id, Opportunity> oldMap = (Map<Id, Opportunity>) Trigger.oldMap;
    for (Opportunity record : (List<Opportunity>) Trigger.new) {
      if (record.Amount != oldMap.get(record.Id).Amount && record.Amount > AMOUNT_LIMIT) {
        amountChecker();
      }
    }
  }
  
  public static void amountChecker() {
    throw new OpportunityAmountException('Amount Should Not Be Greater Than 5000');
  }
  
  public class OpportunityAmountException extends Exception {
  }
  
  public static void onAfterInsert(){
    List<Opportunity> records = (List<Opportunity>) Trigger.new;
    rollAmountOnAccount(records);
  }
  
  public static void onAfterUpdate(){
    Map<Id,Opportunity> newMap = (Map<Id,Opportunity>)Trigger.newMap;
    Map<Id,Opportunity> oldMap = (Map<Id,Opportunity>) Trigger.oldMap;
    List<Opportunity> opportunities = new List<Opportunity>();
    for(Id oppId : newMap.keySet()){
      if(oldMap.containsKey(oppId) && oldMap.get(oppId).Amount != newMap.get(oppId).Amount){
        opportunities.add(newMap.get(oppId));
      }
    }
    if(opportunities.isEmpty()){
      return;
    }
    rollAmountOnAccount(opportunities);
  }
  
  public static void onAfterDelete(){
    List<Opportunity> records = (List<Opportunity>) Trigger.old;
    rollAmountOnAccount(records);
  }
  
  public static void onAfterUndelete(){
    List<Opportunity> records = (List<Opportunity>)Trigger.new;
    rollAmountOnAccount(records);
  }
  
  public static void rollAmountOnAccount(List<Opportunity> records){
    List<Id> accountIds = new List<Id>();
    for(Opportunity record : records){
      if(String.isNotBlank(record.AccountId)){
        accountIds.add(record.AccountId);
      }
    }
    List<AggregateResult> results = [SELECT Sum(Amount) amount,AccountId accountId from Opportunity where AccountId IN :accountIds Group By AccountId];
    if(results.isEmpty()){
      return;
    }
    List<Account> accounts = new List<Account>();
    for(AggregateResult result : results){
      accounts.add(new Account(Id=(Id)result.get('accountId'), Opportunity_Amount__c=(Double)result.get('amount')) );
    }
    update accounts;
  }
  
  public static void filterRecords(List<Opportunity> records){
    List<Opportunity> opportunities = new List<Opportunity>();
    for(Opportunity record : records){
      if(String.isBlank(String.valueOf(record.Amount))){
        continue;
      }
      opportunities.add(record);
    }
    if(opportunities.isEmpty()){
      return;
    }
    rollAmountOnAccount(opportunities);
  }
  
  public static void validateStageType(){
    Map<Id,Opportunity> newMap = (Map<Id,Opportunity>) Trigger.newMap;
    Map<Id,Opportunity> oldMap = (Map<Id,Opportunity>) Trigger.oldMap;
    for(Opportunity record : newMap.values()){
      Opportunity oldRecord = oldMap.get(record.Id);
      if((record.StageName == 'Closed Won' && record.Opportunity_Type__c == 'High' && oldRecord.CloseDate != record.CloseDate)){
        record.addError('CloseDate Cannot be edited');
      }
    }
  }
  
}