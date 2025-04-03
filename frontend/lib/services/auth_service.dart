import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/token_storage.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:5001/auth';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Salvar dados de autenticação
        await TokenStorage.saveAuthData(
          token: data['token'],
          userId: data['user']['id'],
          username: data['user']['username'],
          name: data['user']['name'],
          email: data['user']['email'],
        );

        return data;
      } else {
        throw Exception(
            json.decode(response.body)['error'] ?? 'Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to connect to server');
    }
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String username,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);

        // Salvar dados de autenticação
        await TokenStorage.saveAuthData(
          token: data['token'],
          userId: data['user']['id'],
          username: data['user']['username'],
          name: data['user']['name'],
          email: data['user']['email'],
        );

        return data;
      } else {
        throw Exception(
            json.decode(response.body)['error'] ?? 'Failed to register');
      }
    } catch (e) {
      throw Exception('Failed to connect to server');
    }
  }

  // Função de logout
  Future<void> logout() async {
    try {
      final token = await TokenStorage.getToken();

      // Chama o backend para registrar o logout (opcional)
      await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Independente da resposta do servidor, limpa os dados locais
      await TokenStorage.clearAuthData();
    } catch (e) {
      // Mesmo se o servidor estiver indisponível, limpa os dados locais
      await TokenStorage.clearAuthData();
      // Pode logar o erro se necessário
      print('Erro durante logout: $e');
    }
  }
}
