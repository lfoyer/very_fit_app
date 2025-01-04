// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity.dart';
import '../models/goal.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api';  // For Android emulator
  final String? token;

  ApiService({this.token});
  //'24bc9d1709361fe6777d3512ec1dc33969bfb51d';

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token',
  };

  Future<List<Activity>> getActivities() async {
    final response = await http.get(
      Uri.parse('$baseUrl/activities/'),
      //headers: headers,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      }
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Activity.fromJson(json)).toList();
    }
    throw Exception('Failed to load activities');
  }

  /* Future<Activity> createActivity(Activity activity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/activities/'),
      headers: headers,
      body: json.encode(activity.toJson()),
    );
    if (response.statusCode == 201) {
      return Activity.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create activity');
  } */
  Future<Activity> createActivity(Activity activity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/activities/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: json.encode(activity.toJson()),
    );
    if (response.statusCode == 201) {
      return Activity.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create activity');
  }

  Future<List<Goal>> getGoals() async {
    final response = await http.get(
      Uri.parse('$baseUrl/goals/'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Goal.fromJson(json)).toList();
    }
    throw Exception('Failed to load goals');
  }

  Future<Goal> createGoal(Goal goal) async {
    final response = await http.post(
      Uri.parse('$baseUrl/goals/'),
      headers: headers,
      body: json.encode(goal.toJson()),
    );
    if (response.statusCode == 201) {
      return Goal.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create goal');
  }
}