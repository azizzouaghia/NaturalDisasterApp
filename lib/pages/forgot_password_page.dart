import 'package:first_app/styles/app_colors.dart';
import 'package:flutter/material.dart';

const textColor = AppColors.white;
const buttonColor = AppColors.font;

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
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
                  "Forgot Password?",
                  style: TextStyle(color: textColor, fontSize: 22),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Enter your email to reset your password",
                  style: TextStyle(color: textColor),
                ),
                const Spacer(),
                TextField(
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
                    print('Reset Password');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text('Reset Password'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      "Remember your password?",
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
