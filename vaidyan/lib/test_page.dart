import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatelessWidget {
  Future<String> _callAnswerAPI(String text) async {
    final response = await http.post(
      Uri.parse('https://3f5983c2-175c-44cf-8f1d-d987a1c8d91b-00-254vq5qtc47zr.pike.replit.dev/devRAG'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({"query": text}),
    );

    
      final Map<String, dynamic> data = json.decode(response.body);
      return data['output'];
   
      
    
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
