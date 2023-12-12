import 'dart:async';
import 'package:first_app/models/earthquake_model.dart';
import 'package:first_app/pages/earthquack_details.dart';
import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:first_app/widgets/location_row.dart';
import 'package:first_app/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:first_app/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool alert = false;
  List<Earthquake> earthquakes = [];
  Timer? _fetchTimer;

  @override
  void initState() {
    super.initState();
    // Fetch earthquakes immediately when the widget is initialized
    fetchEarthquakes(context);

    // Start a timer to fetch updates periodically
    _fetchTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      fetchEarthquakes(context);
    });
  }

  Future<void> fetchEarthquakes(BuildContext context) async {
    final appAuthProvider =
        Provider.of<AppAuthProvider>(context, listen: false);
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;
    ;
    final url =
        'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=${currentYear - 1}-${currentMonth}-${currentDay}&endtime=${currentYear}-${currentMonth}-${currentDay}&minmagnitude=4.0&minlongitude=${appAuthProvider.longitude - 3}&minlatitude=${appAuthProvider.latitude - 3}&maxlatitude=${appAuthProvider.latitude + 3}&maxlongitude=${appAuthProvider.longitude + 3}';

    final response = await http.get(Uri.parse(url));
    print(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final features = data['features'];

      List<Earthquake> fetchedEarthquakes = features.map<Earthquake>((feature) {
        final properties = feature['properties'];
        final geometry = feature['geometry']['coordinates'];

        return Earthquake(
          place: properties['place'],
          time: DateTime.fromMillisecondsSinceEpoch(properties['time']),
          latitude: geometry[1],
          longitude: geometry[0],
          details: properties['detail'],
        );
      }).toList();

      setState(() {
        earthquakes = fetchedEarthquakes;
      });
    } else {
      // Handle errors
      print('Failed to load earthquake data');
    }
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _fetchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarWidget(
        title: "Dashboard Statistics",
      ),
      drawer: const NavigationDrawerWidget(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const LocationRow(),
          const SizedBox(height: 20),
          const Text("Earthquake Statistics",
              style: TextStyle(fontSize: 17, color: AppColors.white)),
          const SizedBox(height: 5),
          Consumer<AppAuthProvider>(
            builder: (context, appAuthProvider, _) {
              // Remove the immediate fetch here as it's already done in initState
              return EarthquakeCard(
                alert: alert,
                earthquakes: earthquakes,
                onAlertToggle: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}

class EarthquakeCard extends StatelessWidget {
  final bool alert;
  final VoidCallback onAlertToggle; // turn on/off alert
  final List<Earthquake> earthquakes;

  const EarthquakeCard(
      {Key? key,
      required this.alert,
      required this.onAlertToggle,
      required this.earthquakes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
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
              Row(
                children: [
                  SizedBox(width: 50, height: 200),
                  Column(
                    children: earthquakes.take(3).map((earthquake) {
                      return LatestEarthquake(
                        place: earthquake.place,
                        time: earthquake.time,
                        latitude: earthquake.latitude,
                        longitude: earthquake.longitude,
                        details: earthquake.details,
                      );
                    }).toList(),
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

class LatestEarthquake extends StatelessWidget {
  final String place;
  final DateTime time;
  final double longitude;
  final double latitude;
  final String details;

  const LatestEarthquake(
      {Key? key,
      required this.place,
      required this.time,
      required this.longitude,
      required this.latitude,
      required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 240,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Place: $place", style: const TextStyle(fontSize: 14)),
              Text("Time: ${time.toString()}",
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 3),
              Center(
                child: GestureDetector(
                  onTap: () {
                    print("details btn clicked");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EarthquackDetails(
                          earthquake: Earthquake(
                            place: place,
                            time: time,
                            latitude: latitude,
                            longitude: longitude,
                            details: details,
                          ),
                        ),
                      ),
                    );
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
