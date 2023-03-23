import 'package:flutter/material.dart';
import 'package:frontend/screens/overview_screen/overview_screen.dart';
import 'package:frontend/screens/stats_screen/stats_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget body;

    //select screen based on bottom navigation bar index
    switch (_index) {
      case 0:
        body = const OverviewScreen();
        break;
      case 1:
        body = const StatsScreen();
        break;
      case 2:
        body = const Center(child: Text("Profile"));
        break;
      default:
        //error: this should never happen!
        body = const Placeholder();
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart_outlined),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_outlined),
            label: 'Admin',
          ),
        ],
      ),
    );
  }
}
