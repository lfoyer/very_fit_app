// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/activities/activity_screen.dart';
import 'screens/goals/goals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  static const List<Widget> _screens = <Widget>[
    DashboardScreen(),
    ActivityScreen(),
    GoalsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Activities',
          ),
          NavigationDestination(
            icon: Icon(Icons.flag),
            label: 'Goals',
          ),
        ],
      ),
    );
  }
}