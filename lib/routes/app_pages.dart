import 'package:get/get.dart';
import '../views/welcome_page.dart';
import '../views/login_page.dart';
import '../views/home_page.dart';
import '../views/settings_page.dart';

class AppRoutes {
  static const welcome = '/welcome';
  static const login = '/login';
  static const home = '/home';
  static const settings = '/settings';

  // 👇 This is the missing getter
  static final routes = [
    GetPage(name: welcome, page: () => WelcomePage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: settings, page: () => SettingsPage()),
  ];
}
