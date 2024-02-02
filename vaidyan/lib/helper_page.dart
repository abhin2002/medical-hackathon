// helper_page.dart

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HelperPage extends StatefulWidget {
  const HelperPage({Key? key}) : super(key: key);

  @override
  _HelperPageState createState() => _HelperPageState();
}

class _HelperPageState extends State<HelperPage> {
  String selectedLanguage = 'English'; // Default language
  TextEditingController messageController = TextEditingController();
  List<String> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Help button in the AppBar
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _getAndPrintLocation();
            },
          ),
          // DropdownButton in the AppBar to select different languages
          DropdownButton<String>(
            value: selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                selectedLanguage = newValue!;
              });
              // Add logic here to change the language as needed
            },
            items: <String>['English', 'Malayalam']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Logo at the middle of the top
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/logo.jpeg', // Replace with your actual logo asset path
                height: 100,
                width: 100,
              ),
            ),
          ),
          // Chat Interface
          Expanded(
            child: ListView(
              children: chatMessages.map((message) => _buildMessage(message)).toList(),
            ),
          ),
          // Text Input Field and Send Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Future<void> _getAndPrintLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("Current Location: ${position.latitude}, ${position.longitude}");
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _sendMessage(String message) {
    // Implement logic to send the message
    print("User: $message");

    // Add the user's message to the chat interface
    _receiveMessage("User: $message");

    // Add logic for responding to the message if needed
    // For example, you can simulate a response:
    _receiveMessage("Response: Thank you for your message!");

    messageController.clear();
  }

  void _receiveMessage(String message) {
    setState(() {
      // Add the received message to the chat interface
      chatMessages.add(message);
    });
  }
}
