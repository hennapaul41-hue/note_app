import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/local_storage.dart';
import '../routes/app_routes.dart';

class RegistrationController extends GetxController {
  // ✅ Controllers
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  // ✅ Password visibility
  var isPasswordHidden = true.obs;

  final storage = LocalStorage();

  // ✅ SIGN UP FUNCTION
  void signUp() async {
    final name = username.text.trim();
    final mail = email.text.trim();
    final pass = password.text.trim();

    // VALIDATION
    if (name.isEmpty) {
      Get.snackbar("Error", "Username required");
      return;
    }

    if (mail.isEmpty) {
      Get.snackbar("Error", "Email required");
      return;
    }

    if (!mail.endsWith("@gmail.com")) {
      Get.snackbar("Error", "Email must be a Gmail account");
      return;
    }

    if (pass.isEmpty) {
      Get.snackbar("Error", "Password required");
      return;
    }

    if (pass.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters");
      return;
    }

    if (name == pass) {
      Get.snackbar("Error", "Username and password must be different");
      return;
    }

    // SAVE USER
    await storage.saveUser(username: name, email: mail, password: pass);

    Get.snackbar("Success", "Account created");

    // NAVIGATE
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
