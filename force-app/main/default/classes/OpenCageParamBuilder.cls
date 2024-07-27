public with sharing class OpenCageParamBuilder {
  public String formattedAddress;

  public OpenCageParamBuilder setAddress(String address) {
    this.formattedAddress = address + ', ';
    return this;
  }

  public OpenCageParamBuilder setCountry(String country) {
    this.formattedAddress = country + ', ';
    return this;
  }

  public OpenCageParamBuilder setPostalCode(String postalCode) {
    this.formattedAddress = postalCode;
    return this;
  }

  public String build() {
    return this.formattedAddress;
  }
}
