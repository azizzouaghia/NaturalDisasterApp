import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String name = "Aziz Zouaghia";
  String dateOfBirth = "1990-01-01";
  String profilePictureUrl = "https://example.com/profile.jpg";
  String location = "Choose Location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfilePicture(),
            const SizedBox(height: 16),
            _buildNameSection(),
            const SizedBox(height: 16),
            _buildDateOfBirthSection(),
            const SizedBox(height: 16),
            _buildLocationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: NetworkImage(profilePictureUrl),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _changeProfilePicture();
          },
          child: const Text("Change Profile Picture"),
        ),
      ],
    );
  }

  Widget _buildNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _changeName();
          },
          child: const Text("Change Name"),
        ),
      ],
    );
  }

  Widget _buildDateOfBirthSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date of Birth",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          dateOfBirth,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _changeDateOfBirth(context);
          },
          child: const Text("Change Date of Birth"),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          location,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _chooseLocation(context);
          },
          child: const Text("Choose Location"),
        ),
      ],
    );
  }

  void _changeProfilePicture() {
    // TODO: Implement logic to change profile picture
    // You might want to use image_picker or other plugins
    // Example:
    // setState(() {
    //   profilePictureUrl = "new_profile_picture_url";
    // });
  }

  void _changeName() {
    // TODO: Implement logic to change name
    // You might want to use text input or other methods
    // Example:
    // setState(() {
    //   name = "new_name";
    // });
  }

  Future<void> _changeDateOfBirth(BuildContext context) async {
    // TODO: Implement logic to change date of birth
    // You might want to use date picker or other methods
    // Example using date picker:
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(dateOfBirth),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != DateTime.parse(dateOfBirth)) {
      setState(() {
        dateOfBirth = pickedDate.toIso8601String().split("T")[0];
      });
    }
  }

  Future<void> _chooseLocation(BuildContext context) async {
    // Navigate to MapPage to choose location
    final String? selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MapPage()),
    );

    if (selectedLocation != null && selectedLocation.isNotEmpty) {
      setState(() {
        location = selectedLocation;
      });
    }
  }
}

// New MapPage
class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement map interface and logic
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Location"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement logic to get selected location from map
            Navigator.of(context).pop("Selected Location");
          },
          child: const Text("Select Location on Map"),
        ),
      ),
    );
  }
}
