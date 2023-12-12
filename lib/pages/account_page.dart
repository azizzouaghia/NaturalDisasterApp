import 'package:first_app/auth_provider.dart';
import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:first_app/widgets/location_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String name = "Aziz Zouaghia";
  String dateOfBirth = "1990-01-01";
  String location = "Choose Location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarWidget(
        title: "Account Settings",
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Consumer<AppAuthProvider>(
          builder: (context, appAuthProvider, _) {
            String username = appAuthProvider.username;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(child: _buildProfilePicture()),
                const SizedBox(height: 20),
                _buildNameSection(username),
                const SizedBox(height: 20),
                _buildLocationSection(),
                const SizedBox(height: 20),
                MapWidget(
                  latitude: appAuthProvider.latitude,
                  longitude: appAuthProvider.longitude,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: NetworkImage(
              "https://media.shafaq.com/media/arcella/1697820719299.jpeg"),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildNameSection(String username) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Username"),
        const SizedBox(height: 8),
        _buildSectionText(username),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Location"),
        const SizedBox(height: 8),
        LocationRow(),
      ],
    );
  }

  // Helper methods

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: AppColors.white),
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
                initialCenter: LatLng(latitude, longitude), initialZoom: 12),
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
