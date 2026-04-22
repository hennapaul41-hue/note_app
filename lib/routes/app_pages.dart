import 'package:flutter/material.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';
import '../views/welcome_page.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.welcome: (context) => const WelcomePage(),
  };
}
