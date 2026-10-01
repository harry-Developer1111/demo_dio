class ApiEndpoints {
  static const String baseUrl = 'https://api.restful-api.dev';

  static const String register = '/register';
  static const String login = '/login';

  //use in bottom sheet work
  static String products(String category) {
    return '/collections/$category/objects';
  }

}