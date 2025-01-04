// lib/screens/activities/activity_screen.dart
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../models/activity.dart';
import '../../services/api_service.dart';
import '../../services/local_storage.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ApiService _apiService = ApiService();
  final LocalStorage _localStorage = LocalStorage();
  final _formKey = GlobalKey<FormState>();
  
  String _type = 'RUN';
  int _duration = 0;
  double? _distance;
  int _calories = 0;

  Future<void> _submitActivity() async {
    if (_formKey.currentState!.validate()) {
      final activity = Activity(
        type: _type,
        duration: _duration,
        distance: _distance,
        calories: _calories,
        createdAt: DateTime.now(),
        syncId: DateTime.now().toIso8601String(),
      );

      try {
        final connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult != ConnectivityResult.none) {
          // Online - send to server
          await _apiService.createActivity(activity);
        } else {
          // Offline - save locally
          await _localStorage.saveActivity(activity);
        }
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Activity saved')),
          );
          _formKey.currentState!.reset();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error saving activity')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Activity')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              value: _type,
              decoration: const InputDecoration(labelText: 'Activity Type'),
              items: const [
                DropdownMenuItem(value: 'RUN', child: Text('Running')),
                DropdownMenuItem(value: 'BIKE', child: Text('Cycling')),
                DropdownMenuItem(value: 'GYM', child: Text('Workout')),
              ],
              onChanged: (value) {
                setState(() => _type = value!);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter duration';
                }
                return null;
              },
              onChanged: (value) => _duration = int.tryParse(value) ?? 0,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Distance (km)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _distance = double.tryParse(value),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter calories';
                }
                return null;
              },
              onChanged: (value) => _calories = int.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitActivity,
              child: const Text('Save Activity'),
            ),
          ],
        ),
      ),
    );
  }
}