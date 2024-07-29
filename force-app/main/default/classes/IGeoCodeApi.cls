public interface IGeoCodeApi {
  List<Decimal> getLatLong(String address);
  String getAddress(Decimal lat, Decimal lang);
}
