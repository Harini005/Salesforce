public virtual with sharing class Animal {
  public String name { get; private set; }
  public Integer age { get; private set; }

  public Animal(String name, Integer age) {
    this.name = name;
    this.age = age;
  }

  public virtual void walk() {
    System.debug('Animal is walking');
  }

  public virtual void swim() {
    System.debug('Animal is swimming');
  }

  public virtual void sleep() {
    System.debug('Animal is sleeping');
  }

  public virtual void Bark() {
    System.debug('Animal is Barking');
  }

  public virtual void run() {
    System.debug('Animal is running');
  }

  public void breath() {
    System.debug('Breathing');
  }
}
