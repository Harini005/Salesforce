public with sharing class AccountTriggerHandler {
    public static void onBeforeInsert(){
        RegionManagerUtility utility = RegionManagerUtility.getInstance();
        for(Account record : (List<Account>)Trigger.New){
           record.Region_Manager__c = utility.responseMap.get(record.Region__c);
        }
    }

    public static void onBeforeUpdate(){
        Map<Id,Account> newMap = (Map<Id,Account>)Trigger.newMap;
        System.debug(Json.serializePretty(newMap));
        for(Account record : (List<Account>)Trigger.New){
            System.debug(record);
        }
    }
}