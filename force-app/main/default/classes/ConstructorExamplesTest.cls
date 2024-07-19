@IsTest(IsParallel=false)
public with sharing class ConstructorExamplesTest {
  @IsTest
  static void callZeroParamsConstructor() {
    ConstructorExamples ex = new ConstructorExamples();
    Integer counter = ex.printNumber();
    Assert.areEqual(counter, 5, 'Counter is not set to 5');
  }

  @IsTest
  static void callParameterizedConstructor() {
    ConstructorExamples ex = new ConstructorExamples(20);
    Integer counter = ex.printNumber();
    Assert.areEqual(counter, 20, 'Counter is not set to 20');
  }

  @IsTest
  static void callMultiParameterizedConstructor() {
    ConstructorExamples ex = new ConstructorExamples(20, 'Welcome');
    Integer counter = ex.printNumber();
    Assert.areEqual(counter, 20, 'Counter is not set to 20');
    Assert.areEqual(ex.greetings, 'Welcome', 'Greetings is not set to Welcome');
  }
}
