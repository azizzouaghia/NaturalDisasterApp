import 'package:first_app/widgets/bar_widget.dart';
import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarWidget(
        title: "Help and Support",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCard("FAQs", [
                "Q: How can I change my password?",
                "A: You can change your password in the Settings page.",
              ]),
              _buildCard("Contact Us", [
                "Email: mohamedaziz.zouaghia@edu.isetcom.tn, samar.mhenni@edu.isetcom.tn",
                "Phone: 71255658",
              ]),
              _buildFeedbackForm(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, List<String> content) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content.map((item) => Text(item)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackForm() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Feedback",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Enter your feedback here...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  // Implement the logic to handle the feedback submission
                },
                child: Text("Submit Feedback"),
                style: ButtonStyle(
                  //size
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 40)),
                )),
          ],
        ),
      ),
    );
  }
}
