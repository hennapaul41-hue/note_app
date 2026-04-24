import '../model/user_settings.dart';

class SettingsController {
  final UserSettings model;

  SettingsController({required this.model});

  void changeEmail(String newEmail) => model.updateEmail(newEmail);
  void changePassword(String newPassword) => model.updatePassword(newPassword);

  Future<void> saveSettings() async => await model.save();

  void logout() {
    print("User logged out");
  }
}
