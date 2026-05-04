import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/local_storage.dart';
import '../routes/app_routes.dart';
import '../models/settings_model.dart';

class RegistrationController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  var isPasswordHidden = true.obs;

  final LocalStorage storage = LocalStorage();

  /// Sign up logic
  Future<void> signUp() async {
    if (username.text.trim().isNotEmpty &&
        password.text.trim().isNotEmpty &&
        email.text.trim().endsWith("@gmail.com")) {
      // ✅ Save user data using SettingsModel
      final settings = SettingsModel(
        username: username.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
      );
      await storage.setUserData(settings);

      await storage.setLoggedIn(true);
      Get.offAllNamed(AppRoutes.home);

      Get.snackbar("Success", "Account created successfully!");
    } else {
      Get.snackbar("Error", "Enter valid Username, Password & Gmail");
    }
  }

  /// Logout logic
  Future<void> logout() async {
    await storage.clearSession(); // ✅ clears saved session
    Get.offAllNamed(AppRoutes.welcome); // ✅ navigate back to WelcomePage
    Get.snackbar("Logout", "You have been logged out");
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    email.dispose();
    super.onClose();
  }
}
