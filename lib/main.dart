import 'package:flutter/material.dart';
import 'services/local_storage.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'views/home_page.dart';
import 'views/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLogin() async {
    return await LocalStorage().getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ✅ use AppPages
      routes: AppPages.routes,

      home: FutureBuilder<bool>(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return snapshot.data == true ? const HomePage() : const WelcomePage();
        },
      ),
    );
  }
}
