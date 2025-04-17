import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class NearestHospitalPage extends StatefulWidget {
  const NearestHospitalPage({super.key});

  @override
  State<NearestHospitalPage> createState() => _NearestHospitalPageState();
}

class _NearestHospitalPageState extends State<NearestHospitalPage> {
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  List<Marker> _buildHospitalMarkers() {
    if (currentLocation == null) return [];

    return [
      Marker(
        point: currentLocation!,
        width: 40,
        height: 40,
        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      ),
      Marker(
        point: LatLng(currentLocation!.latitude + 0.001, currentLocation!.longitude + 0.001),
        width: 40,
        height: 40,
        child: const Icon(Icons.local_hospital, color: Colors.green, size: 35),
      ),
      Marker(
        point: LatLng(currentLocation!.latitude - 0.0015, currentLocation!.longitude + 0.002),
        width: 40,
        height: 40,
        child: const Icon(Icons.local_hospital, color: Colors.green, size: 35),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearest Hospitals')),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: currentLocation,
                zoom: 16,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: _buildHospitalMarkers(),
                ),
              ],
            ),
    );
  }
}
