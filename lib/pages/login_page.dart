import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart' as provider;
import 'package:first_app/auth_provider.dart';

const textColor = AppColors.white;
const buttonColor = AppColors.font;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                const Text(
                  "Hello, Welcome back!",
                  style: TextStyle(color: textColor, fontSize: 22),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Login to Continue",
                  style: TextStyle(color: textColor),
                ),
                const Spacer(),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: textColor.withOpacity(0.8),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: textColor.withOpacity(0.8),
                  ),
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/forgot_password');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: textColor,
                    ),
                    child: const Text("Forgot Password?"),
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      String email = emailController.text;
                      String password = passwordController.text;

                      _performLogin(context, email, password);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: buttonColor),
                    child: const Text("Log in"),
                  ),
                ),
                const Spacer(),
                const Text(
                  "OR",
                  style: TextStyle(color: textColor),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("google login");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textColor,
                    foregroundColor: buttonColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 22,
                        height: 22,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text("Login with Google")
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("facebook login");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textColor,
                    foregroundColor: buttonColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/facebook.png',
                        width: 22,
                        height: 22,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text("Login with Facebook")
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: textColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/sign_up');
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: buttonColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _performLogin(
      BuildContext context, String email, String password) async {
    try {
      // Sign in with email and password using Firebase Authentication
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // If login is successful, get user information from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Notify AuthProvider about successful login
      provider.Provider.of<AppAuthProvider>(context, listen: false)
          .updateUserInformation(userDoc); // Use the alias here

      // If login is successful, show a toast message and navigate to home
      Fluttertoast.showToast(
        msg: "Login successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      //_showDialog(context, "Error", "Error during login: $e");
      _showDialog(context, "Error", "Invalid username or password.");
    }
  }

  void _showDialog(BuildContext context, String titleMessage, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleMessage),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
