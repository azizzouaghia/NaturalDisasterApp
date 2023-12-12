import 'dart:convert';

import 'package:first_app/models/earthquake_model.dart';
import 'package:first_app/pages/home_pages.dart';
import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class EarthquackDetails extends StatefulWidget {
  final Earthquake earthquake;

  const EarthquackDetails({Key? key, required this.earthquake})
      : super(key: key);

  @override
  _EarthquackDetailsState createState() => _EarthquackDetailsState();
}

class _EarthquackDetailsState extends State<EarthquackDetails> {
  num? depth;
  num? magnitude;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = widget.earthquake.details;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Ensure depth is of type double
      depth = data['geometry']['coordinates'][2].toDouble();

      // Extract magnitude directly without accessing 'properties' key
      magnitude = data['properties']['mag'];

      print(depth);
      print(magnitude);

      setState(() {
        depth = data['geometry']['coordinates'][2].toDouble();
        magnitude = data['properties']['mag'];
      });
    } else {
      // Handle the error
      print('Failed to load earthquake details: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarWidget(
        title: "Dashboard Statistics",
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              "More details",
              style: TextStyle(fontSize: 17, color: AppColors.white),
            ),
          ),
          const SizedBox(height: 5),
          DetailsCard(
            earthquake: widget.earthquake,
            magnitude: magnitude,
            depth: depth,
          ),
        ],
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  final Earthquake earthquake;
  final num? depth;
  final num? magnitude;

  const DetailsCard({
    Key? key,
    required this.earthquake,
    required this.depth,
    required this.magnitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Limit the location string to 24 characters if it's too long
    String displayLocation = earthquake.place;
    if (displayLocation.length > 24) {
      displayLocation = displayLocation.substring(0, 27) + '...';
    }

    return SizedBox(
      height: 400,
      width: MediaQuery.of(context).size.width - 40,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            DetailsLine(title: "Location", value: displayLocation),
            DetailsLine(
              title: "Date",
              value: earthquake.time.toLocal().toString(),
            ),
            const SizedBox(height: 10),
            DetailsLine(title: "Depth", value: "${depth} km"),
            const SizedBox(height: 10),
            DetailsLine(
              title: "Magnitude",
              value: magnitude.toString(),
            ),
            const SizedBox(height: 10),
            Text(
              "Map :",
              style: TextStyle(fontSize: 13, color: AppColors.font),
            ),
            const SizedBox(height: 10),
            MapWidget(
              latitude: earthquake.latitude,
              longitude: earthquake.longitude,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsLine extends StatelessWidget {
  final String title;
  final String value;
  const DetailsLine({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title :",
            style: const TextStyle(fontSize: 13, color: AppColors.font)),
        const SizedBox(width: 10),
        Text(value,
            style: const TextStyle(fontSize: 13, color: AppColors.black)),
      ],
    );
  }
}

class MapWidget extends StatelessWidget {
  final double longitude;
  final double latitude;
  const MapWidget({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 210,
          width: MediaQuery.of(context).size.width - 100,
          child: FlutterMap(
            options: MapOptions(
                initialCenter: LatLng(latitude, longitude), initialZoom: 8),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(latitude, longitude),
                    width: 100,
                    height: 100,
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.font,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
