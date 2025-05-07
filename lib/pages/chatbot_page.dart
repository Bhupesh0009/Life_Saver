import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _greetUser();
  }

  void _greetUser() {
    setState(() {
      _messages.add({'bot': "Hello! I'm your Life Saver assistant. 👋"});
      _messages.add({'bot': "Would you like to schedule a medical appointment?"});
      _messages.add({'bot': "Please tell me your preferred date and time."});
    });
  }

  void _handleUserMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({'user': text});
      _messages.add({'bot': 'Thanks! We received your request for "$text". We’ll confirm it shortly.'});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot Assistant'),
        backgroundColor: isDark ? Colors.black : Colors.redAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.containsKey('user');

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: isUser
                          ? (isDark ? Colors.blue[700] : Colors.blue[100])
                          : (isDark ? Colors.grey[800] : Colors.grey[300]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message[isUser ? 'user' : 'bot']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type your response...',
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: isDark ? Colors.grey[900] : Colors.white,
                    ),
                    onSubmitted: _handleUserMessage,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _handleUserMessage(_controller.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.redAccent : Colors.blue,
                  ),
                  child: const Text('Send'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
