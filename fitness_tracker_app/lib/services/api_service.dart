import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity.dart';
import '../models/goal.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api';  // For Android emulator
  
  Future<List<Activity>> getActivities() async {
    final response = await http.get(Uri.parse('$baseUrl/activities/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Activity.fromJson(json)).toList();
    }
    throw Exception('Failed to load activities');
  }

  Future<Activity> createActivity(Activity activity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/activities/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(activity.toJson()),
    );
    if (response.statusCode == 201) {
      return Activity.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create activity');
  }

  Future<List<Goal>> getGoals() async {
    final response = await http.get(Uri.parse('$baseUrl/goals/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Goal.fromJson(json)).toList();
    }
    throw Exception('Failed to load goals');
  }
}