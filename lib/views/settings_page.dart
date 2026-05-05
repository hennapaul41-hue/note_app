import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../widgets/editable_field_widget.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final SettingsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text(
          "Edit Account",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: controller.logout,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[700]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              EditableFieldWidget(
                label: "NAME",
                controller: controller.usernameController,
                originalValue: controller.originalName,
                isEditing: controller.isEditingName,
                errorText: controller.nameError,
                onSave: controller.saveName,
                onCancel: controller.cancelEditName,
              ),
              EditableFieldWidget(
                label: "EMAIL ADDRESS",
                controller: controller.emailController,
                originalValue: controller.originalEmail,
                isEditing: controller.isEditingEmail,
                errorText: controller.emailError,
                onSave: controller.saveEmail,
                onCancel: controller.cancelEditEmail,
              ),
              EditableFieldWidget(
                label: "PASSWORD",
                controller: controller.passwordController,
                originalValue: controller.originalPassword,
                isEditing: controller.isEditingPassword,
                errorText: controller.passwordError,
                onSave: controller.savePassword,
                onCancel: controller.cancelEditPassword,
                isPassword: true,
                isPasswordVisible: controller.isPasswordVisible,
                onTogglePassword: controller.togglePasswordVisibility,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
