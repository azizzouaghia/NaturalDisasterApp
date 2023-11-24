import 'package:first_app/pages/ForgotPasswordPage.dart';
import 'package:first_app/pages/home_pages.dart';
import 'package:first_app/pages/SignUpPage.dart';
import 'package:flutter/material.dart';

const textColor = Colors.white;
const buttonColor = Color.fromRGBO(41, 128, 185, 1.0);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                  decoration: InputDecoration(
                    hintText: 'username',
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
                  decoration: InputDecoration(
                    hintText: 'password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: textColor.withOpacity(0.8),
                  ),
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
                      Navigator.of(context).pushReplacementNamed('/home');
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
}
