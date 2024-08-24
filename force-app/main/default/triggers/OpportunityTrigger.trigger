trigger OpportunityTrigger on Opportunity(before insert, before update, after insert , after delete , after update , after undelete) {
  if (Trigger.isBefore && Trigger.isInsert) {
    //OpportunityTriggerHandler.onBeforeInsert();
  }
  if (Trigger.isBefore && Trigger.isUpdate) {
    //OpportunityTriggerHandler.onBeforeUpdate();
  }
  
  //Roll Up Amount on Opportunity and Update it on related Account.
  if(Trigger.isAfter){
    if(Trigger.isInsert){
      OpportunityTriggerHandler.onAfterInsert();
    }
    if(Trigger.isUpdate){
      OpportunityTriggerHandler.onAfterUpdate();
    }
    if(Trigger.isDelete){
      OpportunityTriggerHandler.onAfterDelete();
    }
    if(Trigger.isUndelete){
      OpportunityTriggerHandler.onAfterUndelete();
    }
  }
}