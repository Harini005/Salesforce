public with sharing class UserTriggerHandler {
    public static void onAfterUpdate(){
        Map<Id,User> newMap = (Map<Id,User>) Trigger.newMap;
        Map<Id,User> oldMap = (Map<Id,User>) Trigger.oldMap;
        Map<Id , User> userIds = new Map<Id , User>();
        for(User record : newMap.values()){
            if(record.country != oldMap.get(record.Id).country){
                userIds.put(record.Id , record);
            }
        }
        if(userIds.isEmpty()){
            return;
        }
        updateAddressOnOpportunity(userIds);
    }
    
    private static void updateAddressOnOpportunity(Map<Id, User> userIds){
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Opportunity opp :  [SELECT Id,Location__c,OwnerId from Opportunity where OwnerId IN :userIds.keySet()]){
            opp.Location__c = userIds.get(opp.OwnerId).country;
            opportunities.add(opp);
        }
        if(Opportunities.isEmpty()){
            return;
        }
        update opportunities;
    }
}