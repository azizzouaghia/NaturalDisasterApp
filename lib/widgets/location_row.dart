import 'package:first_app/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:first_app/styles/app_colors.dart';
import 'package:provider/provider.dart';

class LocationRow extends StatelessWidget {
  const LocationRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppAuthProvider>(
      builder: (context, appAuthProvider, _) {
        double latitude = appAuthProvider.latitude;
        double longitude = appAuthProvider.longitude;

        return FutureBuilder(
          future: getAddress(latitude, longitude),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // or some loading indicator
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_pin, color: AppColors.font, size: 20),
                  Text(
                    "Location: ${snapshot.data}",
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  Future<String> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.locality}, ${place.country}";
      } else {
        return "Unknown Location";
      }
    } catch (e) {
      print("Error getting address: $e");
      return "Unknown Location";
    }
  }
}
