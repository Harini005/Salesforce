trigger PE_SAPAccountTrigger on SAP_Account__e (after insert) {
    System.debug('SAP Account Trigger Executed');
    System.debug(JSON.serializePretty(Trigger.new));
}