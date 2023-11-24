import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Forgot your password? Enter your email address, and we'll send you a link to reset your password.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold, // Make text bold
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset link sent!')),
                );
              },
              child: const Text(
                'Reset Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Make button text bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
