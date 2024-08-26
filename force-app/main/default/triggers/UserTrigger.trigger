trigger UserTrigger on User (after Update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            UserTriggerHandler.onAfterUpdate();
        }
    }
}