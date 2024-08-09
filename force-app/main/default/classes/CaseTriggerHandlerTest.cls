@IsTest
public with sharing class CaseTriggerHandlerTest {
  @IsTest
  static void whenCaseInserts_setPriorityToHigh() {
    Account account = new Account(Name = 'Test Account', Rating = 'Hot');
    insert account;

    Case record = new Case(AccountId = account.Id);
    insert record;

    Assert.areEqual('High', record.Priority);
  }
}
