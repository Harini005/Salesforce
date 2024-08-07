public with sharing class SortingSobject {
  public List<Account> accounts;
  public SortingSobject() {
    accounts = new List<Account>{
      new Account(Name = 'sForce', Industry = 'Biotechnology', Site = 'Austin'),
      new Account(Name = 'sForce', Industry = 'Agriculture', Site = 'New York'),
      new Account(Name = 'Acme')
    };
  }

  public List<Account> sortSobject() {
    this.accounts.sort();
    return this.accounts;
  }
}

// List<Account> records = new SortingSobject().sortSobject();
// System.debug(JSON.serializePretty(records));
// output : {
//   "Name" : "Acme"
// }, {
//   "Name" : "sForce",
//   "Industry" : "Agriculture",
//   "Site" : "New York"
// }, {
//   "Name" : "sForce",
//   "Industry" : "Biotechnology",
//   "Site" : "Austin"
// } ]

