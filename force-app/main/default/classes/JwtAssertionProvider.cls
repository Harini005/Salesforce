public with sharing class JwtAssertionProvider {
  private static final String header = '{"alg" : "RS256}';

  public static void run() {
    DateTime current = System.now();
    current = current.addMinutes(3);
    Long expiration = current.getTime();
    String claims =
      '{' +
      '"iss" : "3MVG9WVXk15qiz1JmcIS.iBgC1KtiLTI_NRQnTEUrDl4rj71KChf74mkPzlS.R9su2bjyA7X429W8lHP5CY4p",' + //client Id
      '"aud" : "https://login.salesforce.com",' + //login url
      '"sub" : "harinigovindarajan005@int.com",' + //userName in server
      '"exp" :' +
      expiration + //unix time stamp
      '}';

    String encodedHeader = encodeString(header);
    String encodedClaims = encodeString(claims);

    String combinedHeaderClaim = encodedHeader + '.' + encodedClaims;

    String jwtAssertion = shaSignPrivateKey(combinedHeaderClaim);
    System.debug(jwtAssertion);

    getAccessToken(jwtAssertion);
  }

  private static String encodeString(String data) {
    String response = EncodingUtil.base64Encode(Blob.valueOf(data))
      .replace('/', '_')
      .replace('+', '-')
      .replaceAll('=+$', '');
    return response;
  }

  private static String shaSignPrivateKey(String combinedHeaderClaim) {
    Blob privateKey = EncodingUtil.base64Decode(getPrivateKey('server'));
    String result = Crypto.sign('RSA-SHA256', Blob.valueOf(combinedHeaderClaim), privateKey).toString();
    combinedHeaderClaim += '.' + result;
    return combinedHeaderClaim;
  }

  private static String getPrivateKey(String Name) {
    ContentVersion record = [SELECT Id, VersionData FROM ContentVersion WHERE Title = :Name];
    String privateKey = record.VersionData.toString()
      .replace('-----BEGIN ENCRYPTED PRIVATE KEY-----', '')
      .replace('-', '')
      .replace('-----END ENCRYPTED PRIVATE KEY-----', '')
      .replaceAll('\n', '');
    return privateKey;
  }

  private static void getAccessToken(String jwtAssertion) {
    HttpRequest req = new HttpRequest();
    req.setMethod('Body');
    req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
    req.setBody(
      String.format(
        'grant_type={0}&assertion={1}',
        new List<String>{ 'urn:ietf:params:0auth:grant-type:jwt-bearer', jwtAssertion }
      )
    );
    HttpResponse respone = new Http().send(req);
  }
}

// JwtAssertionProvider.run();

