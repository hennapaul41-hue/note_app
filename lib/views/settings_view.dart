import 'package:flutter/material.dart';
import '../services/local_storage.dart';
import '../routes/app_routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final storage = LocalStorage();

    usernameController.text = await storage.getUsername() ?? '';
    passwordController.text = await storage.getPassword() ?? '';

    setState(() {});
  }

  Future<void> save() async {
    final storage = LocalStorage();

    await storage.setUsername(usernameController.text.trim());
    await storage.setPassword(passwordController.text.trim());

    setState(() => isEditing = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Updated successfully")),
    );
  }

  Future<void> logout() async {
    await LocalStorage().clearSession();

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => isEditing = true),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              enabled: isEditing,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passwordController,
              enabled: isEditing,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            if (isEditing)
              ElevatedButton(
                onPressed: save,
                child: const Text("Save"),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: logout,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
