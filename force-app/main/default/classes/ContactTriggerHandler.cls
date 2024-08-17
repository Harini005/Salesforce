/**
 * @description : Get the Details of the Parent Record Without using For Loop
 * @Credentials : harinigovindarajan005@all.com
 */
public with sharing class ContactTriggerHandler {
  public static void beforeInsert(List<Contact> newRecords) {
    List<Contact> contacts = [SELECT Id, AccountId, Account.Name FROM Contact WHERE Id IN :newRecords];
    System.debug(Json.serializePretty(contacts));
  }
  
  public static void preventDuplicateContact(){
    List<Contact> newContacts = (List<Contact>)Trigger.new;
    Set<String> recordMatch = new Set<String>();
    for(Contact record : newContacts){
      recordMatch.add(record.Email);
      recordMatch.add(record.Phone);
    }
    recordMatch.remove(null);
    List<Contact> matches = [SELECT Id,Email,Phone from Contact where Email IN :recordMatch OR Phone IN : recordMatch];
    
    if(Matches.isEmpty()){
      return;
    }
    Map<String,Contact> contactMatches = new Map<String,Contact>();
    for(Contact match : matches){
      contactMatches.put(match.Email , match);
      contactMatches.put(match.Phone , match);
    }
    
    for(Contact record : newContacts){
      if(contactMatches.containsKey(record.Email) || contactMatches.containsKey(record.Phone)){
        record.addError('Duplicate record found. Please change the Values');
      }
    }
  }
}