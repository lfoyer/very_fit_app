// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/activity.dart';

class AuthService {
  final String baseUrl = 'http://localhost:8000';
  //final String baseUrl = 'http://localhost:8000/api';
  static const String tokenKey = 'auth_token';

  Future<String?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api-token-auth/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );
      print("Login response: ${response.body}"); // Debug line
      print("Status code: ${response.statusCode}"); // Debug line

      if (response.statusCode == 200) {
        final token = json.decode(response.body)['token'];
        await _saveToken(token);
        return token;
      }
      return null;
    } catch (e) {
      print("Login error: $e"); // Debug line
      return null;
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  Map<String, String> get headers => {
    'Content-Type': 'application/json'
  };

  Future<Activity> createActivity(Activity activity) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/activities/'),
        headers: headers,
        body: json.encode(activity.toJson()),
      );
      print("Response: ${response.body}");
      if (response.statusCode == 201) {
        return Activity.fromJson(json.decode(response.body));
      }
      throw Exception('Failed: ${response.body}');
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

    // TODO goals create
}
