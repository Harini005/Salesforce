public with sharing class RegionManagerUtility {
  private static RegionManagerUtility utility { get; private set; }
  public Map<String, String> responseMap { get; private set; }

  private RegionManagerUtility() {
    this.responseMap = new Map<String, String>();
    List<Region__c> regions = [SELECT Id, Name, Manager__c FROM Region__c];
    for (Region__c region : regions) {
      this.responseMap.put(region.Name, region.Manager__c);
    }
  }

  public static RegionManagerUtility getInstance() {
    if (utility == null) {
      utility = new RegionManagerUtility();
    }
    return utility;
  }
}
