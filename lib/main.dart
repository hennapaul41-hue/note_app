import 'package:flutter/material.dart';
import 'model/user_settings.dart';
import 'controll/settings_controller.dart';
import 'view/settings_view.dart';

void main() {
  final model = UserSettings();
  final controller = SettingsController(model: model);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SettingsView(controller: controller),
    ),
  );
}
