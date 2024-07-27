public with sharing class JWTAcessTokenProvider {
    //JWTAcessTokenProvider.run();
  public static void run() {
    String header = '{"alg":"RS256"}';
    DateTime current = System.now();
    current = current.addMinutes(10);
    Long expiration = current.getTime();
    String claims =
      '{' +
      '"iss" : "3MVG9WVXk15qiz1JmcIS.iBgC1KtiLTI_NRQnTEUrDl4rj71KChf74mkPzlS.R9su2bjyA7X429W8lHP5CY4p",' + //client Id
      '"aud" : "https://login.salesforce.com",' + //login url
      '"sub" : "harinigovindarajan005@int.com",' + //userName in server
      '"exp" :' +
      expiration + //unix time stamp
      '}';

    String encodedHeader = EncodeBase64(header);
    String encodedClaims = EncodeBase64(claims);
    String combinedHeaderClaims = encodedHeader+'.'+encodedClaims;
    String signature = EncodeBase64(String.valueOf(Crypto.signWithCertificate('RSA-SHA256', Blob.valueOf(combinedHeaderClaims), 'integration')));
    String jwtAssertion = combinedHeaderClaims+'.'+signature;
    System.debug(jwtAssertion);
  }

  private static String EncodeBase64(String data) {
    String encodedData = EncodingUtil.base64Encode(Blob.valueOf(data));
    encodedData = encodedData.replaceAll('/', '_').replace('+', '-').replaceAll('=+$', '');
    return encodedData;
  }
}
