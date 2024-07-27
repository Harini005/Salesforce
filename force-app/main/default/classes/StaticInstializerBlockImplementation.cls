public with sharing class StaticInstializerBlockImplementation {
  /**
   * Order of Exection
   * Static Variables
   * Static Initializer block
   * Initailaizer block
   * constructor
   */
  public static String color = 'Red';

  {
    color = 'Green';
    System.debug(color);
  }

  static {
    System.debug(color);
    color = 'Yellow';
    System.debug(color);
  }

  public StaticInstializerBlockImplementation() {
    System.debug('Inside No-params Constructor');
  }

  public StaticInstializerBlockImplementation(String color) {
    System.debug('Inside params Constructor');
  }
}

// StaticInstializerBlockImplementation instance = new StaticInstializerBlockImplementation();
// StaticInstializerBlockImplementation instanceNew = new StaticInstializerBlockImplementation('Pink');
// Debug
// Red
// Yellow
// Green
// Inside No-params Constructor
// Green
// Inside params Constructor

