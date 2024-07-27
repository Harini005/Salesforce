public with sharing class RandomJokeApiService {
    
  public static void getRandomJoke() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('callout:RandomJoke');
    request.setMethod('GET');
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('Accept', 'application/json');
    HttpResponse response = http.send(request);
    System.debug(Json.serializePretty(response.getBody()));
  }

  //RandomJokeApiService.getRandomJoke();
}
