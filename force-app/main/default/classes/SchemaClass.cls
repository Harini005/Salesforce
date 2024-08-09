public with sharing class SchemaClass {
  public static void run() {
    Sobject details = new Account();
    System.debug(details.getSobjectType()); //to get the SobjectType

    Schema.describeSobjectResult accountMetadata = details.getSobjectType().getDescribe();
    System.debug(JSON.serialize(accountMetadata)); //get the metadata of the Sobject.

    // Schema.DescribeFieldResult nameInfo = Account.SobjectType.Name.getDescibe();
    // System.debug(JSON.serializePretty(nameInfo));

    Map<String, Schema.SobjectType> objectMap = Schema.getGlobalDescribe();
    System.debug(JSON.serializePretty(objectMap.keySet()));
  }
}

//SchemaClass.run();

