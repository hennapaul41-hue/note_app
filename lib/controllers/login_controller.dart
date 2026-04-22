import 'package:flutter/material.dart';
import '../services/local_storage.dart';

class LoginController {
  final storage = LocalStorage();

  Future<void> login(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter email and password")),
      );
      return;
    }

    if (!email.endsWith("@gmail.com")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Use Gmail account")),
      );
      return;
    }

    // ✅ store login
    await storage.setLogin(true);

    // ✅ use ROUTE
    Navigator.pushReplacementNamed(context, '/home');
  }
}
