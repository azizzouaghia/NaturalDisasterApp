import 'package:first_app/styles/app_colors.dart';
import 'package:flutter/material.dart';

class LocationRow extends StatelessWidget {
  const LocationRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_pin, color: AppColors.font, size: 20),
        Text("Location: ariana",
            style: TextStyle(fontSize: 16, color: AppColors.white)),
      ],
    );
  }
}
