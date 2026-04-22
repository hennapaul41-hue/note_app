import 'package:flutter/material.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';
import '../views/welcome_page.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String welcome = '/welcome';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    welcome: (context) => const WelcomePage(),
  };
}
