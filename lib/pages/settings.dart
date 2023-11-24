import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(width: 8),
            const Text("Settings"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSettingsButton(context, "Account", Icons.person, "/account"),
            _buildSettingsButton(context, "Notifications", Icons.notifications,
                "/notifications"),
            _buildSettingsButton(context, "Privacy and Security",
                Icons.security, "/privacy_and_security"),
            _buildSettingsButton(
                context, "Help and Support", Icons.help, "/help_and_support"),
            _buildSettingsButton(context, "About", Icons.info, "/about"),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
