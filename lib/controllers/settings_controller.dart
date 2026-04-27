import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/local_storage.dart';

class SettingsController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isEditing = false.obs;
  final isPasswordHidden = true.obs;

  final LocalStorage storage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    usernameController.text = await storage.getUsername() ?? '';
    passwordController.text = await storage.getPassword() ?? '';
    update();
  }

  Future<void> save() async {
    await storage.setUsername(usernameController.text.trim());
    await storage.setPassword(passwordController.text.trim());

    isEditing.value = false;

    Get.snackbar(
      "Success",
      "Updated successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.shade100,
    );
  }

  Future<void> logout() async {
    await storage.clearSession();
    Get.offAllNamed(AppRoutes.login);
  }
}
