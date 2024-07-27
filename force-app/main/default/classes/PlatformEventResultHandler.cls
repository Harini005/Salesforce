public with sharing class PlatformEventResultHandler implements EventBus.EventPublishSuccessCallback, EventBus.EventPublishFailureCallback {
  public void onSuccess(eventbus.SuccessResult result) {
    insertResultHolders(result.getEventUuids());
  }

  public void onFailure(eventBus.FailureResult result) {
    insertResultHolders(result.getEventUuids());
  }

  private static void insertResultHolders(List<String> uuIds) {
    List<Platform_Event_Result_Holder__c> platformEvents = new List<Platform_Event_Result_Holder__c>();
    for (String uuId : uuIds) {
      Platform_Event_Result_Holder__c peResultHolder = new Platform_Event_Result_Holder__c(
        Even_UUID__c = uuId
      );
      platformEvents.add(peResultHolder);
    }
    insert platformEvents;
  }
}
