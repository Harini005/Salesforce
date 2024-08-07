trigger OpportunityTrigger on Opportunity(before insert, before update) {
  if (Trigger.isBefore && Trigger.isInsert) {
    OpportunityTriggerHandler.onBeforeInsert();
  }
  if (Trigger.isBefore && Trigger.isUpdate) {
    OpportunityTriggerHandler.onBeforeUpdate();
  }
}
