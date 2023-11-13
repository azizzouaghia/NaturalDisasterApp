import 'package:first_app/pages/earthquack_details.dart';
import 'package:first_app/pages/home_pages.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:first_app/styles/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: AppColors.background),
        home: const LoginPage(),
        initialRoute: "/login",
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/details': (context) => const EarthquackDetails(),
        });
  }
}
