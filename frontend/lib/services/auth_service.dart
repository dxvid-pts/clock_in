import 'dart:convert';

import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/error_code.dart';
import 'package:frontend/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

final authProvider =
    ChangeNotifierProvider<AuthNotifier>((ref) => AuthNotifier());

class AuthNotifier extends ChangeNotifier {
  User? user;
  bool get isLoggedIn => user != null;

  Future<Box<User>>? _box;

  AuthNotifier() {
    
    _box = _initBoxAndUser();
  }

  Future<Box<User>> _initBoxAndUser() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    final box = await Hive.openBox<User>('user');

    if(box.containsKey("user")){
      user = box.get("user");

      notifyListeners();
    }

    return box;
  }

  Future<ErrorCode?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    if (email == "user" && password == "user") {
      user = const User(
        id: "user",
        email: "user@user.com",
        isAdmin: false,
        token: "",
        vacationDays: 30,
        hoursPerDay: 8,
        isDemo: true,
      );
      notifyListeners();

      (await _box)?.put("user", user!);

      // No error
      return null;
    } else if (email == "admin" && password == "admin") {
      user = const User(
        id: "admin",
        email: "admin@admin.com",
        isAdmin: true,
        token: "",
        vacationDays: 30,
        hoursPerDay: 8,
        isDemo: true,
      );
      notifyListeners();

       (await _box)?.put("user", user!);

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
          hoursPerDay: 8,
          isDemo: false,
        );

        notifyListeners();

        (await _box)?.put("user", user!);

        return null;
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
    // No error
    return null;
  }

  Future<void> logout() async {
     (await _box)?.delete("user");
    user = null;
    notifyListeners();
  }
}
