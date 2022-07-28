class ServerException implements Exception {
  String message;
  ServerException({this.message = 'default server exception message'});
}

class CacheException implements Exception {}
