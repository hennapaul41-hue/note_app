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
    final savedUsername = await storage.getUsername();
    final savedPassword = await storage.getPassword();

    if (username.text.trim() == savedUsername &&
        password.text.trim() == savedPassword) {
      await storage.setLoggedIn(true);
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar("Login Failed", "Invalid username or password");
    }
  }
}
