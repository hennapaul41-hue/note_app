import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final SettingsController controller = Get.put(SettingsController());

  Widget buildEditableField({
    required String label,
    required TextEditingController textController,
    required String originalValue,
    required RxBool isEditing,
    required RxString errorText,
    required VoidCallback onSave,
    required VoidCallback onCancel,
    bool obscure = false,
  }) {
    return Obx(() {
      final bool hasChanged = textController.text != originalValue &&
                              textController.text.trim().isNotEmpty;

      return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: textController,
              obscureText: obscure,
              onTap: () => isEditing.value = true,
              onChanged: (val) {
                isEditing.value = true;
                if (val.trim().isEmpty) {
                  errorText.value = "Required";
                } else {
                  errorText.value = "";
                }
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: const Color(0xFFF7F7F7),
                errorText: errorText.value.isEmpty ? null : errorText.value,
              ),
            ),
            if (isEditing.value)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasChanged
                              ? Colors.blue[600]   // vivid blue when changed
                              : Colors.grey[400], // neutral grey when only tapped
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onSave,
                        child: const Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasChanged
                              ? Colors.orange[600] // vivid orange when changed
                              : Colors.grey[400],  // neutral grey when only tapped
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onCancel,
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Edit Account",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[700]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildEditableField(
                  label: "NAME",
                  textController: controller.usernameController,
                  originalValue: controller.originalName,
                  isEditing: controller.isEditingName,
                  errorText: controller.nameError,
                  onSave: controller.saveName,
                  onCancel: controller.cancelEditName,
                ),
                buildEditableField(
                  label: "EMAIL ADDRESS",
                  textController: controller.emailController,
                  originalValue: controller.originalEmail,
                  isEditing: controller.isEditingEmail,
                  errorText: controller.emailError,
                  onSave: controller.saveEmail,
                  onCancel: controller.cancelEditEmail,
                ),
                buildEditableField(
                  label: "PASSWORD",
                  textController: controller.passwordController,
                  originalValue: controller.originalPassword,
                  isEditing: controller.isEditingPassword,
                  errorText: controller.passwordError,
                  onSave: controller.savePassword,
                  onCancel: controller.cancelEditPassword,
                  obscure: true,
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 8),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      label: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
