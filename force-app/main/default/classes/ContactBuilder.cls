public with sharing class ContactBuilder {
  private Contact record;

  public ContactBuilder() {
    record = new Contact();
  }

  public ContactBuilder setLastName(String lastName) {
    this.record.LastName = lastName;
    return this;
  }

  public ContactBuilder setEmail(String email) {
    this.record.Email = email;
    return this;
  }

  public ContactBuilder setPhone(String phone) {
    this.record.phone = phone;
    return this;
  }

  public ContactBuilder setAccountId(Id accountId){
    this.record.AccountId = accountId;
    return this;
  }

  public Contact build() {
    return this.record;
  }
}
