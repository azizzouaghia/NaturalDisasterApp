import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppAuthProvider extends ChangeNotifier {
  late User? _user;
  bool _isLoading = false;
  // Initialize with an empty
  late String _username = '';
  late double _latitude = 0.0;
  late double _longitude = 0.0;

  User? get user => _user;
  String get username => _username;
  double get latitude => _latitude;
  double get longitude => _longitude;

  bool get isLoading => _isLoading;

  Future<void> updateUserInformation(DocumentSnapshot userDoc) async {
    _user = FirebaseAuth.instance.currentUser;

    // Extract user information
    String email = userDoc.get("email");
    _username = userDoc.get("username");
    _longitude = userDoc.get("longitude");
    _latitude = userDoc.get("latitude");

    // Notify listeners that the user state has changed
    notifyListeners();
  }

  // Helper method to update the loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId != null) {
      // User is logged in, fetch user information
      _user = FirebaseAuth.instance.currentUser;

      // Fetch additional user information from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();

      // Extract user information
      _username = userDoc.get("username");
      _longitude = userDoc.get("longitude");
      _latitude = userDoc.get("latitude");

      // Notify listeners that the user state has changed
      notifyListeners();
    }
  }
}
