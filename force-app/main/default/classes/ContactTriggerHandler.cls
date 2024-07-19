/**
 * @description : Get the Details of the Parent Record Without using For Loop
 * @Credentials : harinigovindarajan005@all.com
 */
public with sharing class ContactTriggerHandler {
  public static void beforeInsert(List<Contact> newRecords) {
    List<Contact> contacts = [SELECT Id, AccountId, Account.Name FROM Contact WHERE Id IN :newRecords];
    System.debug(Json.serializePretty(contacts));
  }
}
