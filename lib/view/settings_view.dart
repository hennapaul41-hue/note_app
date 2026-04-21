import 'package:flutter/material.dart';
import '../controll/settings_controller.dart';

class SettingsView extends StatefulWidget {
  final SettingsController controller;

  const SettingsView({super.key, required this.controller});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool isEditingEmail = false;
  bool isEditingPassword = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(
      text: widget.controller.model.email,
    );
    passwordController = TextEditingController(
      text: widget.controller.model.password,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email field with edit option
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: emailController,
                    enabled: isEditingEmail,
                    decoration: const InputDecoration(labelText: "Email"),
                    onChanged: widget.controller.changeEmail,
                  ),
                ),
                IconButton(
                  icon: Icon(isEditingEmail ? Icons.check : Icons.edit),
                  onPressed: () {
                    if (!mounted) return;
                    setState(() {
                      isEditingEmail = !isEditingEmail;
                      if (!isEditingEmail) {
                        widget.controller.changeEmail(emailController.text);
                      }
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Password field with edit option
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: passwordController,
                    enabled: isEditingPassword,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                    onChanged: widget.controller.changePassword,
                  ),
                ),
                IconButton(
                  icon: Icon(isEditingPassword ? Icons.check : Icons.edit),
                  onPressed: () {
                    if (!mounted) return;
                    setState(() {
                      isEditingPassword = !isEditingPassword;
                      if (!isEditingPassword) {
                        widget.controller.changePassword(
                          passwordController.text,
                        );
                      }
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await widget.controller.saveSettings();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Settings saved!")),
                );
              },
              child: const Text("Save"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                widget.controller.logout();
                if (!mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
