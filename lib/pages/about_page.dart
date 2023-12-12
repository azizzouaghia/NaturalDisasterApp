import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:first_app/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarWidget(
        title: "About",
      ),
      drawer: const NavigationDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "About the Application:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.font,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "This application was created by Mohamed Aziz Zouaghia And Samar Mhenni  as part of an academic project at ISETCOM in 2023.",
                      style: TextStyle(fontSize: 16, color: AppColors.font),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Functionality:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.font,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "The application provides information about natural disasters, including earthquakes, air pollution, floods, and wildfires. Users can view statistics, search for earthquakes, and receive notifications about upcoming disasters.",
                      style: TextStyle(fontSize: 16, color: AppColors.font),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
