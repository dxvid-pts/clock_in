import 'package:flutter/material.dart';

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
        body = const Center(child: Text("Explore"));
        break;
      case 1:
        body = const Center(child: Text("Saved"));
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
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
