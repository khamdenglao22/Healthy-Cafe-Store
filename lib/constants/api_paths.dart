class ApiPaths {
  static String baseURL = 'http://19.168.1.21:8080/api/v1/store';

  /// HTTP request methods
  static const String getRequest = 'get';
  static const String postRequest = 'post';
  static const String putRequest = 'put';
  static const String patchRequest = 'patch';
  static const String deleteRequest = 'delete';

  /// api paths
  static String loginPath = '$baseURL/login';
  static String orderPath = '$baseURL/orders';
  static String riderPath = '$baseURL/riders';
}
