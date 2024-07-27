trigger OrderTrigger on Order (after insert) {
    OrderTriggerHanlder.publishEvent();
}