import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/local_storage.dart';

class SettingsController extends GetxController {
  final usernameController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isEditing = false.obs;
  final isPasswordHidden = true.obs;

  final LocalStorage storage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  /// Load saved username into the text field
  Future<void> loadData() async {
    usernameController.text = await storage.getUsername() ?? '';
  }

  /// Save updated username and password
  Future<void> save() async {
    // Validate password fields if user entered something
    if (newPasswordController.text.trim().isNotEmpty ||
        confirmPasswordController.text.trim().isNotEmpty) {
      if (newPasswordController.text.trim() !=
          confirmPasswordController.text.trim()) {
        Get.snackbar("Error", "Passwords do not match",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade100);
        return;
      }
      await storage.setPassword(newPasswordController.text.trim());
    }

    // Always update username
    await storage.setUsername(usernameController.text.trim());

    // Reset editing state
    isEditing.value = false;
    newPasswordController.clear();
    confirmPasswordController.clear();

    Get.snackbar("Success", "Settings updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100);
  }

  /// Clear session and redirect to login
  Future<void> logout() async {
    await storage.clearSession();
    Get.offAllNamed(AppRoutes.login);
  }
}
