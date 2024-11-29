class Apis {
  static const String publicContentUrl = 'http://10.0.2.2:3005/';
  static const String _baseUrl = 'http://10.0.2.2:3005/api/v1';
  static const  String userByToken = '$_baseUrl/auth/user';
  static const String login = '$_baseUrl/auth/login';
  static const String register = '$_baseUrl/auth/register';
  static const String foods = '$_baseUrl/foods';
  static const String favoriteFoods = '$_baseUrl/favorite-foods';
  static const String users = '$_baseUrl/users';
  static const String userProfile = '$_baseUrl/users/profile';


  static const String categories = '$_baseUrl/categories';
  static const String orders = '$_baseUrl/orders';
}

