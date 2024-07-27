/**
 * @description fires the platform event on batch error
 * @Date 27 July 2024
 */
public with sharing class PE_AccountHandler implements Database.Batchable<Sobject>, Database.RaisesPlatformEvents {
  public Database.QueryLocator start(Database.BatchableContext context) {
    return Database.getQueryLocator('SELECT Id,Name from Account');
  }

  public void execute(Database.BatchableContext context, List<Account> records) {
    Integer x = 10 / 0; //fails
  }

  public void finish(Database.BatchableContext context) {
  }

  //Database.executeBatch(new PE_AccountHandler());
}
