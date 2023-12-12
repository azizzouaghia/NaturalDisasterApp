import 'package:first_app/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

const textColor = AppColors.white;
const buttonColor = AppColors.font;

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create an Account",
                  style: TextStyle(color: textColor, fontSize: 22),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Sign up to get started",
                  style: TextStyle(color: textColor),
                ),
                const Spacer(),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'username',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: textColor.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 12),
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
                ),
                const SizedBox(height: 12),
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
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    String email = emailController.text;

                    _getLocationAndSignUp(context, username, password, email);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    //the size of the button
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: textColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: buttonColor,
                      ),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _getLocationAndSignUp(
  BuildContext context,
  String username,
  String password,
  String email,
) async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Check if email or username already exists
    QuerySnapshot emailQuery = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();

    QuerySnapshot usernameQuery = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();

    if (emailQuery.docs.isNotEmpty || usernameQuery.docs.isNotEmpty) {
      // If email or username already exists, show an error message
      // ignore: use_build_context_synchronously
      _showDialog(context, "Error", "Email or username already exists.");
      return;
    }

    // Create a new user with email and password
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Store additional user information in Firestore
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user!.uid)
        .set({
      "username": username,
      "email": email,
      "latitude": position.latitude,
      "longitude": position.longitude,
    });
    // Show a toast message for successful registration
    Fluttertoast.showToast(
      msg: "Registration successful!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Navigator.of(context).pushReplacementNamed('/login');
  } catch (e) {
    print("Error signing up: $e");
    // Provide user feedback on the error
    // ignore: use_build_context_synchronously
    _showDialog(context, "Error", "Error signing up: $e");
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
