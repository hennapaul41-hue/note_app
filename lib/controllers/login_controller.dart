import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/local_storage.dart';

class LoginController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();

  var isPasswordHidden = true.obs;

  final LocalStorage storage = LocalStorage();

  void login() async {
    if (username.text.trim().isNotEmpty && password.text.trim().isNotEmpty) {
      await storage.setUsername(username.text.trim());
      await storage.setPassword(password.text.trim());
      await storage.setLoggedIn(true);

      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar(
        'Login Failed',
        'Please enter Username and Password',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
