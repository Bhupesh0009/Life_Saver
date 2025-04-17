import 'package:flutter/material.dart';

class RouteFinderPage extends StatefulWidget {
  const RouteFinderPage({super.key});

  @override
  State<RouteFinderPage> createState() => _RouteFinderPageState();
}

class _RouteFinderPageState extends State<RouteFinderPage> {
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fastest Route")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _startController,
              decoration: const InputDecoration(labelText: "Start Location"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _endController,
              decoration: const InputDecoration(labelText: "Destination"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _findDistance,
              child: const Text("Find Distance"),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  void _findDistance() {
    if (_startController.text.isNotEmpty && _endController.text.isNotEmpty) {
      setState(() {
        result = "Distance between '${_startController.text}' and '${_endController.text}' is approx. 12.5 km.";
      });
    } else {
      setState(() {
        result = "Please enter both locations.";
      });
    }
  }
}
