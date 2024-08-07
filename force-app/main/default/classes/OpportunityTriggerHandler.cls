public with sharing class OpportunityTriggerHandler {
  public static final Decimal AMOUNT_LIMIT = 5000;
  public static void onBeforeInsert() {
    for (Opportunity record : (List<Opportunity>) Trigger.new) {
      if (record.Amount > AMOUNT_LIMIT) {
        amountChecker();
      }
    }
  }

  public static void onBeforeUpdate() {
    Map<Id, Opportunity> oldMap = (Map<Id, Opportunity>) Trigger.oldMap;
    for (Opportunity record : (List<Opportunity>) Trigger.new) {
      if (record.Amount != oldMap.get(record.Id).Amount && record.Amount > AMOUNT_LIMIT) {
        amountChecker();
      }
    }
  }

  public static void amountChecker() {
    throw new OpportunityAmountException('Amount Should Not Be Greater Than 5000');
  }

  public class OpportunityAmountException extends Exception {
  }
}
