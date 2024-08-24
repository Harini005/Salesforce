trigger CaseTrigger on Case(before insert , after insert, after update) {
  if (Trigger.isBefore && Trigger.isInsert) {
    CaseTriggerHandler.setPriority();
  }
  if(trigger.isAfter){
    if(trigger.isInsert){
      CaseTriggerHandler.updateLatestCaseOnAccount();
    }
    if(trigger.isUpdate){
      CaseTriggerHandler.onAfterUpdate();
    }
  }
  
}