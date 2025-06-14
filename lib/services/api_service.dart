import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl =
      'http://192.168.1.17/flutter-api/apis'; // Ganti dengan URL server Anda

  Future<User> login(String user_email, String user_password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {'user_email': user_email, 'user_password': user_password},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<User> register(
    String user_name,
    String user_email,
    String user_password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register.php'),
      body: {
        'user_name': user_name,
        'user_email': user_email,
        'user_password': user_password,
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }
}
