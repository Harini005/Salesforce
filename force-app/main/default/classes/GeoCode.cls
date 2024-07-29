public with sharing class GeoCode {
  private static Map<String, IGeoCodeApi> instanceMap;
  static {
    List<GeoCode__mdt> metadataRecords = GeoCode__mdt.getAll().values();
    if (instanceMap == null) {
      instanceMap = new Map<String, IGeoCodeApi>();
    }
    for (GeoCode__mdt metadataRecord : metadataRecords) {
      if (!metadataRecord.Active__c) {
        continue;
      }
      Type t = Type.forName(metadataRecord.ClassName__c);
      instanceMap.put(metadataRecord.MasterLabel, (IGeoCodeApi) t.newInstance());
    }
  }

  /**
   * @description Using Google Api to get the Latitude and Longitude of the address
   * @Date 29 July 2024
   * @return List<Decimal>
   */

  public static List<Decimal> getLatLong(String serviceName) {
    List<Decimal> latLng = new List<Decimal>();
    if (instanceMap.containsKey(serviceName)) {
      IGeoCodeApi geoCode = instanceMap.get(serviceName);
      latLng = geoCode.getLatLong('123 Main');
    }
    return latLng;
  }
}

// List<Decimal> latlng = GeoCode.getLatLong('USGeoCode');
// System.debug(latlng);

