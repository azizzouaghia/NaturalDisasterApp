import 'package:first_app/pages/earthquack_details.dart';
import 'package:first_app/pages/search_earthquack.dart';
import 'package:flutter/material.dart';
import 'package:first_app/pages/ForgotPasswordPage.dart';
import 'package:first_app/pages/HelpAndSupportPage.dart';
import 'package:first_app/pages/PrivacyAndSecurityPage.dart';
import 'package:first_app/pages/SignUpPage.dart';
import 'package:first_app/pages/aboutPage.dart';
import 'package:first_app/pages/accountPage.dart';
import 'package:first_app/pages/home_pages.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:first_app/pages/settings.dart';
import 'package:first_app/styles/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const LoginPage(),
      initialRoute: "/login",
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/details': (context) => const EarthquackDetails(),
        '/search': (context) => const SearchEarthquack(),
        '/settings': (context) => const SettingsPage(),
        '/account': (context) => const AccountPage(),
        '/about': (context) => const AboutPage(),
        '/privacy_and_security': (context) => const PrivacyAndSecurityPage(),
        '/help_and_support': (context) => const HelpAndSupportPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/sign_up': (context) => const SignUpPage(),
      },
    );
  }
}
