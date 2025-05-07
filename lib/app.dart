import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/chatbot_page.dart'; // ✅ Add this

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Saver',
      theme: ThemeData.dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/chatbot': (context) => const ChatbotPage(), // ✅ Register route
      },
    );
  }
}
