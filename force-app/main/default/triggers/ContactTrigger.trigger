trigger ContactTrigger on Contact(before insert , before update , after insert , after update , after delete , after undelete) {
  if (Trigger.isBefore && Trigger.isInsert) {
    ContactTriggerHandler.beforeInsert(Trigger.new);
    contactTriggerHandler.preventDuplicateContact();
  }
  if(Trigger.isBefore && Trigger.isUpdate){
    ContactTriggerHandler.preventDuplicateContact();
  }
  if(Trigger.isAfter){
    if(Trigger.isInsert){
      ContactTriggerHandler.updateTotalContactonAccount(Trigger.new);
    }
    if(Trigger.isDelete){
      ContactTriggerHandler.updateTotalContactonAccount(Trigger.old);
    }
    if(Trigger.isUndelete){
      ContactTriggerHandler.updateTotalContactonAccount(Trigger.new);
    }
    if(Trigger.isUpdate){
      ContactTriggerHandler.onAfterUpdate();
    }
  }
}