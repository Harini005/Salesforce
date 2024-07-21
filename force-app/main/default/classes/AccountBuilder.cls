public with sharing class AccountBuilder {
    private Account record;

    public AccountBuilder(){
        record = new Account();
    }

    public AccountBuilder setName(String name){
        this.record.Name = name;
        return this;
    }

    public AccountBuilder setRegion(String region){
        this.record.Region__c = region;
        return this;
    }

    public Account build(){
        return this.record;
    }
}