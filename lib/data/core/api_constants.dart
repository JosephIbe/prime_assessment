class APIConstants {

  APIConstants._();

  static const String baseURL = "https://primeapi-production-3f59.up.railway.app";
  static const String apiVersion = "/api/v1";

  static String login = '/auth/login';
  static String register = '/auth/register';
  static String verifyEmail = '/auth/verify-email';

  static String getAllProducts = '/products/all';
  static String getSingleProduct = '/products/product-details';
  static String deleteMyAccount = '/user/delete-my-account';

}