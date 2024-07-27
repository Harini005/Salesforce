/**
 * @description Publish Platform Event Using Apex
 * @Date 25 July 2024
 */
public with sharing class OrderTrigger Hanlder {
    public OrderTriggerHanlder() {

    }

    public static void publishEvent(){
        List<Order_Status__e> orderStatuses = new List<Order_Status__e>();
        List<Order> orderToPublish = [SELECT OrderNumber from Order where Id IN :Trigger.new];
        for(Order ord : orderToPublish){
            Order_Status__e orderStatus = new Order_Status__e(
                Order_Number__c = ord.OrderNumber,
                Total_Amount__c = 0.00   
            );
            orderStatuses.add(orderStatus);
        }

        EventBus.publish(orderStatuses);
    }
}