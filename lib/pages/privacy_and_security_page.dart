import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:flutter/material.dart';

class PrivacyAndSecurityPage extends StatefulWidget {
  const PrivacyAndSecurityPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyAndSecurityPageState createState() => _PrivacyAndSecurityPageState();
}

class _PrivacyAndSecurityPageState extends State<PrivacyAndSecurityPage> {
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarWidget(
        title: "Privacy and Security",
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Change Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'current password',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
                fillColor: AppColors.white.withOpacity(0.8),
              ),
              onChanged: (value) {
                setState(() {
                  currentPassword = value;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'new password',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
                fillColor: AppColors.white.withOpacity(0.8),
              ),
              onChanged: (value) {
                setState(() {
                  newPassword = value;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'confirm password',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
                fillColor: AppColors.white.withOpacity(0.8),
              ),
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to change password
                _handleChangePassword();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.font,
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }

  void _handleChangePassword() {
    // Add logic to handle password change
    if (newPassword == confirmPassword) {
      // Passwords match, proceed with change
      // Add your implementation here
      print("Password changed successfully");
    } else {
      // Passwords do not match, show an error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("New passwords do not match."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
