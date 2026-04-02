import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../core/app_state.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  GoogleMapController? mapController;
  final LatLng _joburgCenter = const LatLng(-26.2041, 28.0473); // Johannesburg CBD

  final List<Map<String, dynamic>> services = [
    {'type': 'tow', 'name': 'Tow Truck', 'price': 'R450 + R15/km', 'icon': Icons.local_towing},
    {'type': 'jumpstart', 'name': 'Jumpstart', 'price': 'R250 flat', 'icon': Icons.battery_charging_full},
    {'type': 'fuel_delivery', 'name': 'Fuel Delivery', 'price': 'R300 + fuel', 'icon': Icons.local_gas_station},
    {'type': 'tyre_change', 'name': 'Tyre Change', 'price': 'R350', 'icon': Icons.tire_repair},
    {'type': 'lockout', 'name': 'Lockout Service', 'price': 'R280', 'icon': Icons.lock_open},
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TowSwift SA - Customer'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // TODO: Profile / logout later
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _jobungCenter, zoom: 12),
            onMapCreated: (controller) {
              mapController = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),

          // Service buttons overlay (big, touch-friendly for tablet)
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Column(
              children: services.map((service) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ElevatedButton.icon(
                    onPressed: () => _requestService(service['type'] as String),
                    icon: Icon(service['icon'] as IconData, size: 28),
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(service['name'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(service['price'] as String, style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      minimumSize: const Size(double.infinity, 70),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Current location info
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  '📍 Johannesburg area • Tap a service below',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _requestService(String serviceType) {
    // TODO: Later this will create a row in Supabase 'requests' table + show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Requesting $serviceType... (Live matching coming next)'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
