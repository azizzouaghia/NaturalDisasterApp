import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:first_app/widgets/location_row.dart';
import 'package:first_app/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool alert = false;

  void toggleAlert() {
    setState(() {
      alert = !alert;
      print("alert: $alert");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarWidget(),
      drawer: const NavigationDrawerWidget(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const LocationRow(),
          const SizedBox(height: 20),
          const Text("Earthquake Statistics",
              style: TextStyle(fontSize: 17, color: AppColors.white)),
          const SizedBox(height: 5),
          EarthquakeCard(alert: alert, onAlertToggle: toggleAlert),
        ],
      ),
    );
  }
}

class EarthquakeCard extends StatelessWidget {
  final bool alert;
  final VoidCallback onAlertToggle; // turn on/off alert

  const EarthquakeCard(
      {Key? key, required this.alert, required this.onAlertToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      width: MediaQuery.of(context).size.width - 40,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text("Current Status:",
                      style: TextStyle(color: AppColors.font)),
                  SizedBox(width: 8),
                  Text("safe", style: TextStyle(color: Colors.green)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Alert:", style: TextStyle(color: AppColors.font)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onAlertToggle,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: alert ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(alert ? "on" : "off",
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Latest Earthquakes in Your Country:",
                  style: TextStyle(color: AppColors.font)),
              const SizedBox(height: 6),
              const Row(
                children: [
                  SizedBox(width: 50, height: 250),
                  Column(
                    children: [
                      LatestEarthquack(
                          place: "7 km ESE of Chebika",
                          time: "2021-10-10 12:00:00"),
                      SizedBox(height: 8),
                      LatestEarthquack(
                          place: "7 km ESE of Chebika",
                          time: "2021-10-10 12:00:00"),
                      SizedBox(height: 8),
                      LatestEarthquack(
                          place: "7 km ESE of Chebika",
                          time: "2021-10-10 12:00:00"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LatestEarthquack extends StatelessWidget {
  final String place;
  final String time;

  const LatestEarthquack({Key? key, required this.place, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 240,
          height: 76,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Place: $place", style: const TextStyle(fontSize: 14)),
              Text("Time: $time", style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 3),
              Center(
                child: GestureDetector(
                  onTap: () {
                    print("details btn clicked");
                    Navigator.of(context).pushNamed('/details');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: AppColors.font,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Text("Details",
                        style: TextStyle(fontSize: 14, color: AppColors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
