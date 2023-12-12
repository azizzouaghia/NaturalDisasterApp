import 'package:first_app/auth_provider.dart';
import 'package:first_app/pages/search_earthquack.dart';
import 'package:flutter/material.dart';
import 'package:first_app/pages/forgot_password_page.dart';
import 'package:first_app/pages/help_and_support_page.dart';
import 'package:first_app/pages/privacy_and_security_page.dart';
import 'package:first_app/pages/sign_up_page.dart';
import 'package:first_app/pages/about_page.dart';
import 'package:first_app/pages/account_page.dart';
import 'package:first_app/pages/home_pages.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:first_app/pages/settings.dart';
import 'package:first_app/styles/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// ignore: unused_import
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());

  // Initialize AuthProvider and call autoLogin
  AppAuthProvider authProvider = AppAuthProvider();
  authProvider.autoLogin();

  runApp(
    ChangeNotifierProvider(
      create: (context) => authProvider,
      child: const MyApp(),
    ),
  );
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
      home: LoginPage(),
      initialRoute: "/login",
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => const HomePage(),
        '/search': (context) => const SearchEarthquack(),
        '/settings': (context) => const SettingsPage(),
        '/account': (context) => const AccountPage(),
        '/about': (context) => const AboutPage(),
        '/privacy_and_security': (context) => const PrivacyAndSecurityPage(),
        '/help_and_support': (context) => const HelpAndSupportPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/sign_up': (context) => SignUpPage(),
      },
    );
  }
}
