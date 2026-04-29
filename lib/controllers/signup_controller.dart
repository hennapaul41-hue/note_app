import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/local_storage.dart';

class SignUpController extends GetxController {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  var isPasswordHidden = true.obs;

  final LocalStorage storage = LocalStorage();

  void signUp() async {
    // Validate empty fields
    if (username.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        password.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    // Validate Gmail email
    if (!email.text.trim().endsWith("@gmail.com")) {
      Get.snackbar(
        "Error",
        "Email must be a Gmail account",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    // Validate password length
    if (password.text.trim().length < 6) {
      Get.snackbar(
        "Error",
        "Password must be at least 6 characters",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    // Save user data
    await storage.setUsername(username.text.trim());
    await storage.setEmail(email.text.trim());
    await storage.setPassword(password.text.trim());

    // User must log in after sign up
    await storage.setLoggedIn(false);

    // Clear fields
    username.clear();
    email.clear();
    password.clear();

    // Success message
    Get.snackbar(
      "Success",
      "Account created successfully! Please log in.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
    );

    // Redirect to login page
    Get.offAllNamed(AppRoutes.login);
  }
}
