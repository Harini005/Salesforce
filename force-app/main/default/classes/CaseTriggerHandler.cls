public with sharing class CaseTriggerHandler {
  public static Map<String, String> ratingDetails = new Map<String, String>{
    'Hot' => 'High',
    'Cold' => 'Low',
    'Warm' => 'Medium'
  };
  public static void setPriority() {
    for (Case record : [SELECT Priority, Account.Rating, AccountId FROM Case WHERE AccountId != NULL]) {
      record.Priority = ratingDetails.get(record.Account.Rating);
    }
  }
}
