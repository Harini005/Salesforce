public with sharing class Dog extends Animal {
  String breed { get; private set; }
  String color { get; private set; }

  public Dog(String name, Integer age, String breed, String color) {
    super(name, age);
    this.breed = breed;
    this.color = color;
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
