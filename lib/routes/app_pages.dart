import 'package:get/get.dart';
import '../views/welcome_page.dart';
import '../views/login_page.dart';
import '../views/home_page.dart';
import '../views/settings_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.welcome, page: () => const WelcomePage()),
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(name: AppRoutes.home, page: () => HomePage()),
    GetPage(name: AppRoutes.settings, page: () => SettingsPage()),
  ];
}
