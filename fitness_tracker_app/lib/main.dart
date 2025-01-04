import 'package:flutter/material.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/activities/activity_screen.dart';
import 'screens/goals/goals_screen.dart';
import 'screens/login/login_screen.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';

void main() {
  runApp(MaterialApp(
    home: const LoginScreen(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      useMaterial3: true,
    ),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _initApiService();
  }

  Future<void> _initApiService() async {
    final token = await AuthService().getToken();
    setState(() {
      _apiService = ApiService(token: token);
    });
  }

  List<Widget> _screens() => [
    DashboardScreen(apiService: _apiService),
    ActivityScreen(apiService: _apiService),
    GoalsScreen(apiService: _apiService),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _apiService != null ? _screens()[_selectedIndex] : const Center(child: CircularProgressIndicator()),
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