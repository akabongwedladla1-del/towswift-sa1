import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_state.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TowSwift SA - Driver'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.drive_eta, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Driver Mode',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text('Go Online to see nearby requests in Johannesburg'),
            const SizedBox(height: 40),
            SwitchListTile(
              title: const Text('Go Online'),
              value: true, // TODO: connect to is_online in DB
              onChanged: (val) {
                // Later: update driver location + is_online
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Online status updated (realtime coming)')),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text('Waiting for customer requests...'),
          ],
        ),
      ),
    );
  }
}
