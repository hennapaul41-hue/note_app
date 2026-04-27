import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final LocalStorage storage = LocalStorage();
  bool isLoggedIn = await storage.getLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.welcome,
      getPages: AppPages.pages,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
