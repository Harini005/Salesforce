public with sharing class Dog extends Animal {
  public Dog(String name, Integer age) {
    super(name, age);
    System.debug(name);
    System.debug(age);
  }
  //Animal dogrec =new Dog('Tommy',2);

  public override void walk() {
    System.debug(this.name + ' is walking');
    super.sleep();
    super.breath();
  }

  // Animal dogrec =new Dog('Tommy',2);
  // dogrec.walk();
}
