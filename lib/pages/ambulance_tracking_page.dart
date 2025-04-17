import 'package:flutter/material.dart';

class AmbulanceTrackingPage extends StatelessWidget {
  const AmbulanceTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambulance Tracking'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Live ambulance tracking will be shown here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
