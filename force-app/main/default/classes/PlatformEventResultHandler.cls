public with sharing class PlatformEventResultHandler implements EventBus.EventPublishSuccessCallback , EventBus.EventPublishFailureCallback{

    public void onSuccess(eventbus.SuccessResult result){
        System.debug('Success');
        System.debug(result.getEventUuids());
    }

    public void onFailure(eventBus.FailureResult result){
        System.debug('Failed');
        System.debug(result.getEventUuids());
    }
    
}