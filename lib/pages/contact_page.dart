import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Contact Us")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "Enter Your Details here...",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            buildTextField("Enter Your Name Here:"),
            const SizedBox(height: 16),
            buildTextField("Enter Your contact number Here:"),
            const SizedBox(height: 16),
            buildTextField("Enter Your Email-id Here:"),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () {}, child: const Text("Submit")),
            const SizedBox(height: 40),
            const Divider(color: Colors.orange, thickness: 2),
            const SizedBox(height: 8),
            const Text("© 2025 Life Saver. All Rights Reserved.", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Privacy Policy    ", style: TextStyle(color: Colors.white70)),
                Text("Terms & Conditions    ", style: TextStyle(color: Colors.white70)),
                Text("About Us    ", style: TextStyle(color: Colors.white70)),
                Text("Contact Us", style: TextStyle(color: Colors.white70)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            decoration: const InputDecoration(hintText: "Enter Here", filled: true, fillColor: Colors.white10),
          ),
        )
      ],
    );
  }
}
