import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/local_storage.dart';

class SettingsController extends GetxController {
  final storage = LocalStorage();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String originalName = "";
  String originalEmail = "";
  String originalPassword = "";

  var isEditingName = false.obs;
  var isEditingEmail = false.obs;
  var isEditingPassword = false.obs;

  var nameError = "".obs;
  var emailError = "".obs;
  var passwordError = "".obs;

  var isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // LOAD USER
  void loadUserData() async {
    final user = await storage.getUser();

    originalName = user['username'] ?? "";
    originalEmail = user['email'] ?? "";
    originalPassword = user['password'] ?? "";

    usernameController.text = originalName;
    emailController.text = originalEmail;
    passwordController.text = originalPassword;
  }

  // SAVE NAME
  void saveName() async {
    final newValue = usernameController.text.trim();

    if (newValue.isEmpty) {
      nameError.value = "Required";
      return;
    }

    if (newValue == originalName) {
      Get.snackbar("Info", "No changes detected");
      isEditingName.value = false;
      return;
    }

    originalName = newValue;

    await storage.saveUser(
      username: originalName,
      email: originalEmail,
      password: originalPassword,
    );

    isEditingName.value = false;
    Get.snackbar("Success", "Name updated");
  }

  void cancelEditName() {
    usernameController.text = originalName;
    isEditingName.value = false;
  }

  // SAVE EMAIL
  void saveEmail() async {
    final newValue = emailController.text.trim();

    if (newValue.isEmpty) {
      emailError.value = "Required";
      return;
    }

    if (newValue == originalEmail) {
      Get.snackbar("Info", "No changes detected");
      isEditingEmail.value = false;
      return;
    }

    originalEmail = newValue;

    await storage.saveUser(
      username: originalName,
      email: originalEmail,
      password: originalPassword,
    );

    isEditingEmail.value = false;
    Get.snackbar("Success", "Email updated");
  }

  void cancelEditEmail() {
    emailController.text = originalEmail;
    isEditingEmail.value = false;
  }

  // SAVE PASSWORD
  void savePassword() async {
    final newValue = passwordController.text.trim();

    if (newValue.isEmpty) {
      passwordError.value = "Required";
      return;
    }

    if (newValue == originalPassword) {
      Get.snackbar("Info", "No changes detected");
      isEditingPassword.value = false;
      return;
    }

    originalPassword = newValue;

    await storage.saveUser(
      username: originalName,
      email: originalEmail,
      password: originalPassword,
    );

    isEditingPassword.value = false;
    Get.snackbar("Success", "Password updated");
  }

  void cancelEditPassword() {
    passwordController.text = originalPassword;
    isEditingPassword.value = false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void logout() {
    Get.offAllNamed('/welcome');
  }
}
