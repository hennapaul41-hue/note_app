import 'package:flutter/material.dart';
import '../views/welcome_page.dart';
import '../views/login_page.dart';
import '../views/home_page.dart';
import '../view/settings_view.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.welcome: (context) => const WelcomePage(),
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.settings: (context) => const SettingsPage(),
  };
}
