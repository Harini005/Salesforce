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
    Stack stack = new Stack();
    stack.push(1);
    stack.push(2);
    Assert.areEqual(2, stack.pop());
  }

  @IsTest
  static void peekTest() {
    Stack stack = new Stack();
    stack.push(1);
    stack.push(2);
    Assert.areEqual(2, stack.peek());
  }

  @IsTest
  static void sizeTest() {
    Stack stack = new Stack();
    stack.push(1);
    stack.push(2);
    Assert.areEqual(2, stack.size());
  }

  @IsTest
  static void isEmptyTest() {
    Stack stack = new Stack();
    stack.push(1);
    stack.push(2);
    Assert.isFalse(stack.isEmpty());
  }
}
