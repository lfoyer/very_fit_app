// lib/screens/goals/goals_screen.dart
import 'package:flutter/material.dart';
import '../../models/goal.dart';
import '../../services/api_service.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  List<Goal> _goals = [];

  String _type = 'FREQ';
  double _target = 0;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    try {
      final goals = await _apiService.getGoals();
      setState(() => _goals = goals);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _selectDate(bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Goals'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active Goals'),
              Tab(text: 'Add Goal'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Active Goals Tab
            RefreshIndicator(
              onRefresh: _loadGoals,
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final goal = _goals[index];
                  return ListTile(
                    title: Text(goal.type),
                    subtitle: Text(
                      'Target: ${goal.target}\nEnd Date: ${goal.endDate.toString().split(' ')[0]}',
                    ),
                    trailing: Checkbox(
                      value: goal.completed,
                      onChanged: null,
                    ),
                  );
                },
              ),
            ),
            // Add Goal Tab
            Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  DropdownButtonFormField<String>(
                    value: _type,
                    decoration: const InputDecoration(labelText: 'Goal Type'),
                    items: const [
                      DropdownMenuItem(value: 'FREQ', child: Text('Frequency')),
                      DropdownMenuItem(value: 'DIST', child: Text('Distance')),
                      DropdownMenuItem(value: 'CAL', child: Text('Calories')),
                    ],
                    onChanged: (value) {
                      setState(() => _type = value!);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Target'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter target';
                      }
                      return null;
                    },
                    onChanged: (value) => _target = double.tryParse(value) ?? 0,
                  ),
                  ListTile(
                    title: const Text('Start Date'),
                    subtitle: Text(_startDate.toString().split(' ')[0]),
                    onTap: () => _selectDate(true),
                  ),
                  ListTile(
                    title: const Text('End Date'),
                    subtitle: Text(_endDate.toString().split(' ')[0]),
                    onTap: () => _selectDate(false),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Submit goal
                      }
                    },
                    child: const Text('Create Goal'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}