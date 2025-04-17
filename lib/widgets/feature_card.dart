import 'package:flutter/material.dart';
import '../pages/route_finder_page.dart';
import '../pages/nearest_hospital_page.dart';

class FeatureCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        if (title == "Fastest Route") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RouteFinderPage()),
          );
        } else if (title == "Nearest Hospital") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NearestHospitalPage()),
          );
        }
        // No default handler for Ambulance Tracking
      },
      child: Card(
        color: Colors.blueGrey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
