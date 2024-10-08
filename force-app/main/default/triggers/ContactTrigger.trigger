trigger ContactTrigger on Contact(before insert , before update , after insert , after update , after delete , after undelete) {
  if (Trigger.isBefore && Trigger.isInsert) {
    ContactTriggerHandler.beforeInsert(Trigger.new);
    ContactTriggerHandler.preventDuplicateContact();
  }
  if(Trigger.isBefore && Trigger.isUpdate){
    ContactTriggerHandler.onBeforeUpdate();
    ContactTriggerHandler.preventDuplicateContact();
  }
  if(Trigger.isAfter){
    if(Trigger.isInsert){
      ContactTriggerHandler.updateTotalContactonAccount(Trigger.new);
      ContactTriggerHandler.createContactRelationship();
    }
    if(Trigger.isDelete){
      ContactTriggerHandler.updateTotalContactonAccount(Trigger.old);
    }
    if(Trigger.isUndelete){
      ContactTriggerHandler.updateTotalContactonAccount(Trigger.new);
    }
    if(Trigger.isUpdate){
      ContactTriggerHandler.onAfterUpdate();
      ContactTriggerHandler.createContactRelationship();
    }
  }
}