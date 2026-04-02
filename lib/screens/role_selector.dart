import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_state.dart';
import 'customer/customer_home.dart';
import 'driver/driver_home.dart';

class RoleSelectorScreen extends StatelessWidget {
  const RoleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TowSwift SA'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_towing, size: 80, color: Colors.orange),
              const SizedBox(height: 20),
              const Text(
                'Welcome to TowSwift SA',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Tow, Jumpstart, Fuel, Tyre Change & Lockout\nStarting in Johannesburg',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () {
                  final appState = Provider.of<AppState>(context, listen: false);
                  appState.setRole('customer', null); // TODO: replace with real auth later
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const CustomerHomeScreen()),
                  );
                },
                icon: const Icon(Icons.person),
                label: const Text('I Need Roadside Help (Customer)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  final appState = Provider.of<AppState>(context, listen: false);
                  appState.setRole('driver', null);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DriverHomeScreen()),
                  );
                },
                icon: const Icon(Icons.drive_eta),
                label: const Text('I am a Tow Truck Driver'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
