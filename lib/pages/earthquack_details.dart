import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EarthquackDetails extends StatefulWidget {
  const EarthquackDetails({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EarthquackDetailsState createState() => _EarthquackDetailsState();
}

class _EarthquackDetailsState extends State<EarthquackDetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BarWidget(
        title: "Dashboard Statistics",
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text("More details",
                style: TextStyle(fontSize: 17, color: AppColors.white)),
          ),
          SizedBox(height: 5),
          DetailsCard(),
        ],
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: MediaQuery.of(context).size.width - 40,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              DetailsLine(title: "Location", value: "near the coast of Libya"),
              SizedBox(height: 10),
              DetailsLine(
                  title: "Date and Time", value: "2023-04-02, 23:40:42"),
              SizedBox(height: 10),
              DetailsLine(title: "Depth", value: "10 km"),
              SizedBox(height: 10),
              DetailsLine(title: "Magnitude", value: "5.1"),
              SizedBox(height: 10),
              Text("Map :",
                  style: TextStyle(fontSize: 13, color: AppColors.font)),
              SizedBox(height: 10),
              MapWidget(latitude: 36.084518, longitude: 9.370830),
            ]),
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
                initialCenter: LatLng(latitude, longitude), initialZoom: 13),
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
