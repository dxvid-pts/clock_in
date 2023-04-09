import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/screens/auth_screen/auth_screen.dart';
import 'package:frontend/screens/main_screen/main_screen.dart';
import 'package:frontend/services/auth_service.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClockIn',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary:  Color(0xFFd26a07),
        ),
      ),
      home: Consumer(
        builder: (context, ref, mainScreen) {
          final isLoggedIn = ref.watch(authProvider).isLoggedIn;

          return isLoggedIn ? mainScreen! : const AuthScreen();
        },
        child: const MainScreen(),
      ),
    );
  }
}
