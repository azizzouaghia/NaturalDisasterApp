import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:first_app/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarWidget(
        title: "Settings",
      ),
      drawer: const NavigationDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSettingsButton(context, "Account", Icons.person, "/account"),
            const SizedBox(height: 16),
            _buildSettingsButton(context, "Notifications", Icons.notifications,
                "/notifications"),
            const SizedBox(height: 16),
            _buildSettingsButton(context, "Privacy and Security",
                Icons.security, "/privacy_and_security"),
            const SizedBox(height: 16),
            _buildSettingsButton(
                context, "Help and Support", Icons.help, "/help_and_support"),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton(
      BuildContext context, String title, IconData icon, String route) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(route);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AppColors.font2, // Set button color here
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 24),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
