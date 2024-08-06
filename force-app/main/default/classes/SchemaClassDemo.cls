public with sharing class SchemaClassDemo {
  public static void getSobjectDetails() {
    Map<String, Object> resMap = new Map<String, Object>();
    Schema.DescribeSObjectResult result = Account.SobjectType.getDescribe();
    System.debug(JSON.serializePretty(result));
    resMap.put('Label', result.getLabel());
    resMap.put('Name', result.getName());
    resMap.put('Create', result.isCreateable());
    resMap.put('Update', result.isUpdateable());
    resMap.put('Plural', result.getLabelPlural());
    resMap.put('Delete', result.isDeletable());
    resMap.put('UnDelete', result.isUndeletable());
    resMap.put('Custom', result.isCustom());
    resMap.put('Custom Setting', result.isCustomSetting());
    resMap.put('Custom Setting', result.isCustomSetting());
    resMap.put('Mru Enabled', result.isMruEnabled());
    resMap.put('Queryable', result.isQueryable());
    resMap.put('Feed Enabled', result.isFeedEnabled());
    resMap.put('KeyPrefix', result.getKeyPrefix());
    resMap.put('Mergeable', result.isMergeable());
    resMap.put('Searchable', result.isSearchable());
  }

  public static void getSobjectFieldDetails() {
    Schema.DescribeSObjectResult objectInfo = Account.SobjectType.getDescribe();
    Map<String, Schema.SobjectField> fieldsInfo = objectInfo.fields.getMap();
    System.debug(JSON.serializePretty(fieldsInfo.keySet()));
  }

  /**
   * To check whether the field is picklist or not
   */

  public static void picklistValidator() {
    Map<String, String> options = new Map<String, String>();

    Schema.DescribeFieldResult fieldInfo = Account.Industry.getDescribe();
    if (fieldInfo.getType() == Schema.DisplayType.PICKLIST) {
      for (Schema.PicklistEntry entry : fieldInfo.getPicklistValues()) {
        options.put(entry.getLabel(), entry.getValue());
      }
    }
    System.debug(JSON.serializePretty(options));
  }
}
