// test_page.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatelessWidget {
  // Replace this with the actual address where your API is running
  static const String apiUrl = 'http://192.168.120.132:8000/answer';

  Future<String> _callAnswerAPI(String text) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: '{"text": "$text"}',
      
    );

    if (response.statusCode == 200) {
      // Assuming the response is in JSON format
      final Map<String, dynamic> data = json.decode(response.body);
      return data['answer'];
    } else {
      // Handle errors, you might want to show an error message to the user
      throw Exception('Failed to call answer API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              // Replace "Your question here" with the actual question
              String result = await _callAnswerAPI('head pain');
              print(result);
            } catch (e) {
              print('Error calling answer API: $e');
            }
          },
          child: Text('Call Answer API'),
        ),
      ),
    );
  }
}
