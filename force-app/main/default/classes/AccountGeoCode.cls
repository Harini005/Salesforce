public with sharing class AccountGeoCode {
  /**
   * @description Using Google Api to get the Latitude and Longitude of the address
   * @Date 29 July 2024
   * @return List<Decimal>
   */
  public static void getLatLong() {
    IGeoCodeApi googleGeoCode = new GoogleGeoCode();
    List<Decimal> latLong = googleGeoCode.getLatLong('123 Main Strret , New York , NY 1001');
  }
}
