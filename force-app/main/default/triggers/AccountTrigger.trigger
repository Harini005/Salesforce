trigger AccountTrigger on Account(before insert, before update, after insert, after update) {
  if (Trigger.isInsert && Trigger.isBefore) {
    AccountTriggerHandler.onBeforeInsert();
    AccountTriggerHandler.setSalesRep();
  }
  if (Trigger.isBefore && Trigger.isUpdate) {
    AccountTriggerHandler.onBeforeUpdate();
    AccountTriggerHandler.setSalesRep();
  }
  if (Trigger.isAfter && Trigger.isInsert) {
    AccountTriggerHandler.onAfterInsert();
    AccountTriggerHandler.createClientOpportunity(Trigger.newMap);
  }
  if(Trigger.isAfter && Trigger.isUpdate){
    AccountTriggerHandler.sendEmailToOwner();
  }
}