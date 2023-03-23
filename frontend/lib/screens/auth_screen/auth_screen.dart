import 'package:flutter/material.dart';
import 'package:frontend/screens/auth_screen/widgets/login_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: LoginWidget(),
        ),
      ),
    );
  }
}
