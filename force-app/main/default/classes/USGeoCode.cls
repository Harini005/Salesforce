public with sharing class USGeoCode implements IGeoCodeApi {
  public List<Decimal> getLatLong(String address) {
    return new List<Decimal>{ 23.90, 22.90 };
  }
  public String getAddress(Decimal lat, Decimal lng) {
    return null;
  }
}
