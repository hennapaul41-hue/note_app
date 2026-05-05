import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = LocalStorage();
  final loggedIn = await storage.getLoggedIn();

  runApp(MyApp(initialRoute: loggedIn ? AppRoutes.home : AppRoutes.welcome));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
