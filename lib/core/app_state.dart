import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';

class AppState extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  String? userRole; // 'customer' or 'driver'
  String? userId;
  Position? currentPosition;

  // For realtime requests
  List<Map<String, dynamic>> pendingRequests = [];

  void setRole(String role, String? id) {
    userRole = role;
    userId = id;
    notifyListeners();
  }

  Future<void> updateDriverLocation(double lat, double lng) async {
    if (userRole == 'driver' && userId != null) {
      await supabase.from('drivers').upsert({
        'id': userId,
        'current_location': 'POINT($lng $lat)', // PostGIS format
        'is_online': true,
      });
    }
    notifyListeners();
  }

  // We'll expand this for matching logic later
}
