import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:first_app/widgets/location_row.dart';
import 'package:first_app/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_app/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:first_app/pages/earthquack_details.dart';
import 'package:first_app/models/earthquake_model.dart';

class SearchEarthquack extends StatefulWidget {
  const SearchEarthquack({Key? key}) : super(key: key);

  @override
  _SearchEarthquackState createState() => _SearchEarthquackState();
}

class _SearchEarthquackState extends State<SearchEarthquack> {
  DateTime? fromDate;
  DateTime? toDate;
  List<dynamic> searchResults = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
      });
      await fetchEarthquakes();
    }
  }

  Future<void> fetchEarthquakes() async {
    if (fromDate == null || toDate == null) return;

    final appAuthProvider =
        Provider.of<AppAuthProvider>(context, listen: false);

    final url =
        'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=${fromDate!.year}-${fromDate!.month}-${fromDate!.day}&endtime=${toDate!.year}-${toDate!.month}-${toDate!.day}&minmagnitude=4.0&minlongitude=${appAuthProvider.longitude - 5}&minlatitude=${appAuthProvider.latitude - 5}&maxlatitude=${appAuthProvider.latitude + 5}&maxlongitude=${appAuthProvider.longitude + 5}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final features = data['features'];
      print(url);
      setState(() {
        searchResults = features;
      });
    } else {
      print(url);
      print('Failed to load earthquake data');
    }
  }

  void navigateToDetails(dynamic earthquake) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EarthquackDetails(
          earthquake: Earthquake(
            place: earthquake['properties']['place'],
            time: DateTime.fromMillisecondsSinceEpoch(
                earthquake['properties']['time']),
            latitude: earthquake['geometry']['coordinates'][1],
            longitude: earthquake['geometry']['coordinates'][0],
            details: earthquake['properties']['detail'],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarWidget(title: "Earthquack Search"),
      drawer: const NavigationDrawerWidget(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          LocationRow(),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Select Date Range'),
          ),
          if (fromDate != null && toDate != null) // Check for null
            Text(
              'From ${fromDate!.toLocal()} TO ${toDate!.toLocal()}',
              style: const TextStyle(fontSize: 14, color: AppColors.white),
            ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final earthquake = searchResults[index];
                final properties = earthquake['properties'];
                return Card(
                  child: ListTile(
                    title: Text('Location: ${properties['place']}',
                        style: const TextStyle(fontSize: 13)),
                    subtitle: Text(
                        'Date: ${DateTime.fromMillisecondsSinceEpoch(properties['time']).toLocal()}',
                        style: const TextStyle(fontSize: 13)),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.background,
                      ),
                      onPressed: () => navigateToDetails(earthquake),
                      child: const Text('Details'),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
