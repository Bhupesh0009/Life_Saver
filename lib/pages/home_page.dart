import 'package:flutter/material.dart';
import '../pages/about_page.dart';
import '../pages/contact_page.dart';
import '../pages/ambulance_tracking_page.dart'; // NEW: import the tracking page
import '../widgets/feature_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.jpg'),
        ),
        title: const Text('Life Saver'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
            },
            child: const Text('About', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactPage()));
            },
            child: const Text('Contact', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Your Life Saver App',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Life Saver – Your Safety, Your Health, Your Peace of Mind.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: isWide ? 3 : 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  const FeatureCard(
                    imagePath: 'assets/images/route.jpg',
                    title: 'Fastest Route',
                    description: 'Find shortest and fastest path between two locations.',
                  ),
                  const FeatureCard(
                    imagePath: 'assets/images/hospital.jpg',
                    title: 'Nearest Hospital',
                    description: 'Find nearest hospital around your location.',
                  ),
                  FeatureCard(
                    imagePath: 'assets/images/ambulance.jpg',
                    title: 'Ambulance Tracking',
                    description: 'Track your ambulance live from anywhere and anytime.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AmbulanceTrackingPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
