trigger AccountTrigger on Account(before insert, before update, after insert) {
  if (Trigger.isInsert && Trigger.isBefore) {
    AccountTriggerHandler.onBeforeInsert();
  }
  if (Trigger.isBefore && Trigger.isUpdate) {
    AccountTriggerHandler.onBeforeUpdate();
  }
  if (Trigger.isAfter && Trigger.isInsert) {
    AccountTriggerHandler.onAfterInsert();
  }
}
