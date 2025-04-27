import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NearestHospitalPage extends StatefulWidget {
  const NearestHospitalPage({super.key});

  @override
  State<NearestHospitalPage> createState() => _NearestHospitalPageState();
}

class _NearestHospitalPageState extends State<NearestHospitalPage> {
  final Set<Marker> _markers = {};
  LatLng? currentLocation;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
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
      _addMarkers();
    });
  }

  void _addMarkers() {
    if (currentLocation == null) return;

    _markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: currentLocation!,
        infoWindow: const InfoWindow(title: 'You are here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    // Add dummy nearby hospitals (relative positions)
    _markers.addAll([
      Marker(
        markerId: const MarkerId('hospital1'),
        position: LatLng(
          currentLocation!.latitude + 0.001,
          currentLocation!.longitude + 0.0015,
        ),
        infoWindow: const InfoWindow(title: 'Hospital 1'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      Marker(
        markerId: const MarkerId('hospital2'),
        position: LatLng(
          currentLocation!.latitude - 0.0015,
          currentLocation!.longitude + 0.002,
        ),
        infoWindow: const InfoWindow(title: 'Hospital 2'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearest Hospitals')),
      body:
          currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: currentLocation!,
                  zoom: 16,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: _markers,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
    );
  }
}
