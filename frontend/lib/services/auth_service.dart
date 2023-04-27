import 'dart:convert';

import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/error_code.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;

final authProvider =
    ChangeNotifierProvider<AuthNotifier>((ref) => AuthNotifier());

class AuthNotifier extends ChangeNotifier {
  User? user;
  bool get isLoggedIn => user != null;

  AuthNotifier() {}

  Future<ErrorCode?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    /*try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return _errorCodeFromException(e);
    }*/

    if (email == "test" && password == "test") {
      user = const User(
          id: "test",
          email: "test@test.com",
          isAdmin: false,
          token: "",
          vacationDays: 30);
      notifyListeners();

      // No error
      return null;
    } else if (email == "admin" && password == "admin") {
      user = const User(
          id: "admin",
          email: "admin@admin.com",
          isAdmin: true,
          token: "",
          vacationDays: 30);
      notifyListeners();

      // No error
      return null;
    } else {
      Map data = {'email': email, 'password': password};

      final response = await http.post(
        Uri.parse('http://localhost:3001/api/account/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      final bodyJson = json.decode(response.body);

      String? token;
      try {
        token = bodyJson["access_token"];
      } catch (_) {}

      if (token != null) {
        //request user info
        final userInfoResponse = await http.get(
            Uri.parse('http://localhost:3001/api/account/1'),
            headers: {"Authorization": "Bearer $token"});

        final userInfo = json.decode(userInfoResponse.body);

        final bool isAdmin = userInfo["role"] == "Admin";
        final int vacationDays = userInfo["vacationDays"] ?? 30;

        user = User(
          id: userInfo["id"] == null
              ? Commons.generateId()
              : userInfo["id"].toString(),
          email: email,
          isAdmin: isAdmin,
          token: token,
          vacationDays: vacationDays,
        );
      } else {
        //no access token -> invalid credentials
        return ErrorCode.invalidCredentials;
      }
    }
  }

  Future<ErrorCode?> registerWithEmailPassword({
    String? name,
    required String email,
    required String password,
  }) async {
    /*try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return _errorCodeFromException(e);
    }*/

    // No error
    return null;
  }

  Future<void> logout() async {
    //await FirebaseAuth.instance.signOut();
  }
}

ErrorCode _errorCodeFromException(Object e) {
  /* if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'user-disabled':
        return ErrorCode.invalidCredentials;
      case 'user-not-found':
        return ErrorCode.invalidCredentials;
      case 'wrong-password':
        return ErrorCode.invalidCredentials;
      case 'email-already-in-use':
        return ErrorCode.emailInUse;
      case 'invalid-email':
        return ErrorCode.emailInvalid;
      case 'weak-password':
        return ErrorCode.badPasswordLength;
    }*/
  return ErrorCode.unknown;
}
