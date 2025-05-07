import 'package:flutter/material.dart';

class ChatbotFAB extends StatelessWidget {
  const ChatbotFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'chatbot_fab',
      onPressed: () {
        Navigator.pushNamed(context, '/chatbot');
      },
      backgroundColor: Colors.blueAccent,
      child: const Icon(Icons.chat),
    );
  }
}
