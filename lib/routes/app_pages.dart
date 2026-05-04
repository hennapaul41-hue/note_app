import 'package:get/get.dart';
import '../views/welcome_page.dart';
import '../views/registration_page.dart';
import '../views/home_page.dart';
import '../views/add_note_page.dart';
import '../views/edit_note_page.dart';
import '../views/settings_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.welcome, page: () => const WelcomePage()),
    GetPage(name: AppRoutes.registration, page: () => RegistrationPage()),
    GetPage(name: AppRoutes.home, page: () => HomePage()),
    GetPage(name: AppRoutes.addNote, page: () => AddNotePage()),
    GetPage(name: AppRoutes.editNote, page: () => EditNotePage()),
    GetPage(name: AppRoutes.settings, page: () => SettingsPage()),
  ];
}
