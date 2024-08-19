trigger ContactTrigger on Contact(before insert , before update) {
  if (Trigger.isBefore && Trigger.isInsert) {
    ContactTriggerHandler.beforeInsert(Trigger.new);
    contactTriggerHandler.preventDuplicateContact();
  }
  if(Trigger.isBefore && Trigger.isUpdate){
    ContactTriggerHandler.preventDuplicateContact();
  }
}