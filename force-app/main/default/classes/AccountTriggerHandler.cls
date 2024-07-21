public with sharing class AccountTriggerHandler {
  public static void onBeforeInsert() {
    List<Contact> relatedContacts = new List<Contact>();
    RegionManagerUtility utility = RegionManagerUtility.getInstance();

    for (Account record : (List<Account>) Trigger.New) {
      record.Region_Manager__c = utility.responseMap.get(record.Region__c);
    }

    insert relatedContacts;
  }

  public static void onBeforeUpdate() {
    Map<Id, Account> oldMap = (Map<Id, Account>) Trigger.oldMap;
    Map<Id, Account> newMap = (Map<Id, Account>) Trigger.newMap;
    RegionManagerUtility utility = RegionManagerUtility.getInstance();
    for (Account record : newMap.values()) {
      if (oldMap.containsKey(record.Id) && oldMap.get(record.Id).Region__c != record.Region__c) {
        record.Region_Manager__c = utility.responseMap.get(record.Region__c);
      }
    }
  }

  public static void onAfterInsert() {
    List<Account> records = (List<Account>) Trigger.new;
    List<Contact> relatedContacts = new List<Contact>();

    for (Account record : records) {
      Contact relatedContact = new ContactBuilder()
        .setAccountId(record.Id)
        .setLastName(record.Name)
        .setEmail(record.Name.replaceAll(' ', '') + '@all.com')
        .setPhone(record.phone)
        .build();
      relatedContacts.add(relatedContact);
    }

    insert relatedContacts;
  }
}
