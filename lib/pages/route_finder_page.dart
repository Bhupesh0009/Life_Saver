import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class RouteFinderPage extends StatefulWidget {
  const RouteFinderPage({super.key});

  @override
  State<RouteFinderPage> createState() => _RouteFinderPageState();
}

class _RouteFinderPageState extends State<RouteFinderPage> {
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  String result = "";
  GoogleMapController? _mapController;
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  LatLng _initialPosition = const LatLng(37.7749, -122.4194); // Default
  bool showMap = false; // <--- added this

  static const String googleAPIKey = "AIzaSyC1QlP6V0zaoPa8_3eqtHcHoaBfda89BYM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fastest Route")),
      body:
          showMap
              ? GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 12,
                ),
                onMapCreated: (controller) => _mapController = controller,
                polylines: _polylines,
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              )
              : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _startController,
                      decoration: const InputDecoration(
                        labelText: "Start Location",
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _endController,
                      decoration: const InputDecoration(
                        labelText: "Destination",
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _findDistance,
                      child: const Text("Find Route"),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Future<void> _findDistance() async {
    if (_startController.text.isEmpty || _endController.text.isEmpty) {
      setState(() {
        result = "Please enter both locations.";
      });
      return;
    }

    String start = _startController.text;
    String end = _endController.text;

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$start&destination=$end&key=$googleAPIKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final route = data['routes'][0];
        final polyline = route['overview_polyline']['points'];
        final distanceText = route['legs'][0]['distance']['text'];
        final startLocation = route['legs'][0]['start_location'];
        final endLocation = route['legs'][0]['end_location'];

        _showRouteOnMap(polyline);
        _addMarkers(startLocation, endLocation);

        LatLngBounds bounds = LatLngBounds(
          southwest: LatLng(
            startLocation['lat'] < endLocation['lat']
                ? startLocation['lat']
                : endLocation['lat'],
            startLocation['lng'] < endLocation['lng']
                ? startLocation['lng']
                : endLocation['lng'],
          ),
          northeast: LatLng(
            startLocation['lat'] > endLocation['lat']
                ? startLocation['lat']
                : endLocation['lat'],
            startLocation['lng'] > endLocation['lng']
                ? startLocation['lng']
                : endLocation['lng'],
          ),
        );

        setState(() {
          showMap = true; // <--- important change
          result = "Distance: $distanceText";
        });

        await Future.delayed(const Duration(milliseconds: 500)); // tiny wait

        _mapController?.animateCamera(
          CameraUpdate.newLatLngBounds(bounds, 100),
        );
      } else {
        setState(() {
          result = "Error finding route: ${data['status']}";
        });
      }
    } else {
      setState(() {
        result = "Failed to get directions.";
      });
    }
  }

  void _showRouteOnMap(String encodedPolyline) {
    List<LatLng> points = _decodePolyline(encodedPolyline);

    setState(() {
      _polylines = {
        Polyline(
          polylineId: const PolylineId("route"),
          points: points,
          color: Colors.blue,
          width: 6,
        ),
      };
    });
  }

  void _addMarkers(
    Map<String, dynamic> startLocation,
    Map<String, dynamic> endLocation,
  ) {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('start'),
          position: LatLng(startLocation['lat'], startLocation['lng']),
          infoWindow: const InfoWindow(title: 'Start'),
        ),
        Marker(
          markerId: const MarkerId('end'),
          position: LatLng(endLocation['lat'], endLocation['lng']),
          infoWindow: const InfoWindow(title: 'End'),
        ),
      };
    });
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}
