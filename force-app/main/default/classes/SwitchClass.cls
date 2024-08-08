public with sharing class SwitchClass {
  public static void run(Integer i) {
    switch on i {
      when 2 {
        System.debug('2');
      }
      when 3 {
        System.debug('3');
      }
    }
  }
}
