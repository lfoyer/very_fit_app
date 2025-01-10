// lib/screens/dashboard/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/activity.dart';
import '../../models/goal.dart';

class DashboardScreen extends StatefulWidget {
  final ApiService apiService;
  const DashboardScreen({super.key, required this.apiService});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final ApiService _apiService = ApiService();
  List<Activity> _recentActivities = [];
  List<Goal> _activeGoals = [];

  @override
  void initState() {
    super.initState();
    //_apiService = widget.apiService;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final activities = await _apiService.getActivities();
      final goals = await _apiService.getGoals();
      setState(() {
        _recentActivities = activities;
        _activeGoals = goals.where((goal) => !goal.completed).toList();
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Activities',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_recentActivities.isEmpty)
                      const Text('No recent activities')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _recentActivities.take(5).length,
                        itemBuilder: (context, index) {
                          final activity = _recentActivities[index];
                          return ListTile(
                            title: Text(activity.type),
                            subtitle: Text(
                              '${activity.duration} min - ${activity.calories} cal',
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Active Goals',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_activeGoals.isEmpty)
                      const Text('No active goals')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _activeGoals.length,
                        itemBuilder: (context, index) {
                          final goal = _activeGoals[index];
                          return ListTile(
                            title: Text(goal.type),
                            subtitle: Text(
                              'Target: ${goal.target}',
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
