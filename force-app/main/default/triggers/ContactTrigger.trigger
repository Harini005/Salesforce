trigger ContactTrigger on Contact(before insert) {
  if (Trigger.isBefore && Trigger.isInsert) {
    ContactTriggerHandler.beforeInsert(Trigger.new);
  }
}
