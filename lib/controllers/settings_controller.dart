import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/local_storage.dart';
import '../models/settings_model.dart';
import '../views/welcome_page.dart';

class SettingsController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String originalName = "";
  String originalEmail = "";
  String originalPassword = "";

  // Reactive edit flags
  var isEditingName = false.obs;
  var isEditingEmail = false.obs;
  var isEditingPassword = false.obs;

  // Reactive error messages
  var nameError = "".obs;
  var emailError = "".obs;
  var passwordError = "".obs;

  final storage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await storage.getUserData();
    if (user != null) {
      originalName = user.username;
      originalEmail = user.email;
      originalPassword = user.password;

      usernameController.text = originalName;
      emailController.text = originalEmail;
      passwordController.text = originalPassword;
    }
  }

  void clearErrors() {
    nameError.value = "";
    emailError.value = "";
    passwordError.value = "";
  }

  // --- Toggle Editing ---
  void toggleEditName() {
    isEditingName.value = !isEditingName.value;
    clearErrors();
  }

  void toggleEditEmail() {
    isEditingEmail.value = !isEditingEmail.value;
    clearErrors();
  }

  void toggleEditPassword() {
    isEditingPassword.value = !isEditingPassword.value;
    clearErrors();
  }

  // --- Cancel Editing ---
  void cancelEditName() {
    usernameController.text = originalName;
    isEditingName.value = false;
    clearErrors();
  }

  void cancelEditEmail() {
    emailController.text = originalEmail;
    isEditingEmail.value = false;
    clearErrors();
  }

  void cancelEditPassword() {
    passwordController.text = originalPassword;
    isEditingPassword.value = false;
    clearErrors();
  }

  // --- Save Methods ---
  Future<void> saveName() async {
    if (usernameController.text.trim().isEmpty) {
      nameError.value = "Required";
      return;
    }
    originalName = usernameController.text.trim();
    await _persist();
    isEditingName.value = false;
    Get.snackbar(
      "Success",
      "Name updated successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> saveEmail() async {
    if (emailController.text.trim().isEmpty) {
      emailError.value = "Required";
      return;
    }
    if (!emailController.text.contains("@")) {
      emailError.value = "Invalid email";
      return;
    }
    originalEmail = emailController.text.trim();
    await _persist();
    isEditingEmail.value = false;
    Get.snackbar(
      "Success",
      "Email updated successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> savePassword() async {
    if (passwordController.text.trim().isEmpty) {
      passwordError.value = "Required";
      return;
    }
    if (passwordController.text.trim().length < 6) {
      passwordError.value = "Password too short";
      return;
    }
    originalPassword = passwordController.text.trim();
    await _persist();
    isEditingPassword.value = false;
    Get.snackbar(
      "Success",
      "Password updated successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> _persist() async {
    await storage.setUserData(
      SettingsModel(
        username: originalName,
        email: originalEmail,
        password: originalPassword,
      ),
    );
  }

  // --- Logout ---
  Future<void> logout() async {
    await storage.clearSession();
    Get.offAll(() => WelcomePage());
  }
}
