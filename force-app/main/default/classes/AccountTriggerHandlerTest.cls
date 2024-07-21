/**
 * @description : Tests the implementaion of AccountTriggerHandler,RegionManagerUtility
 */
@IsTest(Isparallel=true)
public with sharing class AccountTriggerHandlerTest {
  @TestSetup
  static void makeData() {
    List<Region__c> regions = new List<Region__c>{new Region__c(Name = 'Canada', Manager__c = UserInfo.getUserId()) , new Region__c(Name = 'US', Manager__c = UserInfo.getUserId())};
    insert regions;
  }

  @IsTest
  static void wheAccountInserts_thenSetRegionManager() {
    Account account = new Account(Name = 'Test Account', Region__c = 'Canada');
    Test.startTest();
    insert account;
    Test.stopTest();
    Account record = [SELECT Region_Manager__c FROM Account LIMIT 1];
    Contact relatedContact = [SELECT Id from Contact where AccountId = :record.Id];
    Assert.areEqual(record.Region_Manager__c, UserInfo.getUserId(), 'Region Manager is not set on account');
    Assert.isNotNull(relatedContact, 'Contact not created for the Account');
  }

  @IsTest
  static void wheAccountUpdates_thenSetRegionManager() {
    Account account = new Account(Name = 'Test Account', Region__c = 'Canada');
    Test.startTest();
    insert account;
    Test.stopTest();

    Account updatedAccount = [SELECT Name, Region__c FROM Account LIMIT 1];
    updatedAccount.Region__c = 'US';
    update updatedAccount;

    Account record = [SELECT Region_Manager__c FROM Account LIMIT 1];
    Assert.areEqual(record.Region_Manager__c, UserInfo.getUserId(), 'Region Manager is not set on account');
  }
}
