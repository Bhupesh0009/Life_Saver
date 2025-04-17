import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("About Us")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "About Our Life Saver App",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              "Our app is designed to help people by providing them the fastest and shortest path during any medical emergency. You can also find the nearest hospital around your location, and track your ambulance in real-time.",
              style: TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            /// Feature + Mission Section
            Column(
              children: [
                buildInfoCard(
                  title: "Key Features",
                  items: const [
                    "• Find shortest and fastest path",
                    "• Get real-time location of ambulance",
                    "• Find hospital near you",
                    "• Google Sign-In for easy access",
                    "• Dark mode support for better usability",
                  ],
                ),
                const SizedBox(height: 20),
                buildInfoCard(
                  title: "Our Mission",
                  items: const [
                    "We aim to improve emergency healthcare access using technology, making it easy for everyone to find help instantly and safely.",
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            /// Call to Action
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.orange[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Sign Up Now and Be Prepared to Save Lives!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget to build info cards
  Widget buildInfoCard({required String title, required List<String> items}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(item, style: const TextStyle(color: Colors.white70)),
              )),
        ],
      ),
    );
  }
}
