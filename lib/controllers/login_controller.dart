import 'package:flutter/material.dart';
import '../services/local_storage.dart';
import '../routes/app_routes.dart';

class LoginController {
  final storage = LocalStorage();

  Future<void> login(
      BuildContext context, String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter username and password")),
      );
      return;
    }

    // ✅ SAVE USER DATA
    await storage.setUsername(username);
    await storage.setPassword(password);

    // ✅ LOGIN STATUS
    await storage.setLogin(true);

    // go to home
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }
}
