import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class EditableFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String originalValue;
  final RxBool isEditing;
  final RxString errorText;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final bool isPassword;
  final RxBool? isPasswordVisible;
  final VoidCallback? onTogglePassword;

  const EditableFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.originalValue,
    required this.isEditing,
    required this.errorText,
    required this.onSave,
    required this.onCancel,
    this.isPassword = false,
    this.isPasswordVisible,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();

    return Obx(() {
      final hasChanged =
          controller.text != originalValue && controller.text.trim().isNotEmpty;

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
              controller: controller,
              obscureText:
                  isPassword ? !(isPasswordVisible?.value ?? false) : false,
              onTap: () {
                // ✅ Cancel other edits before enabling this one
                settingsController.cancelAllEdits();
                isEditing.value = true;
              },
              onChanged: (val) {
                isEditing.value = true;
                if (val.trim().isEmpty) {
                  errorText.value = "Required";
                } else {
                  errorText.value = "";
                }
              },
              decoration: InputDecoration(
                errorText: errorText.value.isEmpty ? null : errorText.value,
                filled: true,
                fillColor: const Color(0xFFF7F7F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon:
                    isPassword
                        ? IconButton(
                          icon: Icon(
                            (isPasswordVisible?.value ?? false)
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: onTogglePassword,
                        )
                        : null,
              ),
            ),
            if (isEditing.value)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed:
                            hasChanged
                                ? onSave
                                : null, // ✅ disable if unchanged
                        child: const Text("Update"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onCancel,
                        child: const Text("Cancel"),
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
}
