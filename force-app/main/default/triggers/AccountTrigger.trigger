trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isInsert && Trigger.isBefore){
        AccountTriggerHandler.onBeforeInsert();
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        AccountTriggerHandler.onBeforeUpdate();
    }
}