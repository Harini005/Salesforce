/**
 * @description : Basics of constructors
 * @Credentials : harinigovindarajan005@all.com
 */
public with sharing class ConstructorExamples {
  public Integer counter;
  public String greetings;

  //Zero Params Constructor
  public ConstructorExamples() {
    this.counter = 5;
  }

  //Parameterized Constructors
  public ConstructorExamples(Integer counter) {
    this.counter = counter;
  }

  public ConstructorExamples(Integer counter, String greetings) {
    this.counter = counter;
    this.greetings = greetings;
  }

  public Integer printNumber() {
    System.System.debug(this.counter);
    return this.counter;
  }
}

// ConstructorExamples ex = new ConstructorExamples();
// ex.printNumber(); Prints 5

// ConstructorExamples ex = new ConstructorExamples(10);
// ex.printNumber(); Prints 10

