@IsTest
public with sharing class StackTest {
  @IsTest
  static void pushTest() {
    Stack stack = new Stack();
    stack.push(1);
    stack.push(2);
    Assert.isTrue(stack.peek() == 2, 'Object not in expected order');
  }

  @IsTest
  static void popTest() {
  }

  @IsTest
  static void peekTest() {
  }

  @IsTest
  static void sizeTest() {
  }

  @IsTest
  static void isEmptyTest() {
  }
}
