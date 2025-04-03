import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String usernameKey = 'username';
  static const String nameKey = 'name';
  static const String emailKey = 'email';

  // Salvar dados de autenticação
  static Future<void> saveAuthData({
    required String token,
    required String userId,
    required String username,
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    await prefs.setString(userIdKey, userId);
    await prefs.setString(usernameKey, username);
    await prefs.setString(nameKey, name);
    await prefs.setString(emailKey, email);
  }

  // Obter token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  // Verificar se o usuário está logado
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Limpar todos os dados de autenticação
  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userIdKey);
    await prefs.remove(usernameKey);
    await prefs.remove(nameKey);
    await prefs.remove(emailKey);
  }
}
