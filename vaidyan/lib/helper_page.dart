import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class HelperPage extends StatefulWidget {
  const HelperPage({Key? key}) : super(key: key);

  @override
  _HelperPageState createState() => _HelperPageState();
}

class _HelperPageState extends State<HelperPage> {
  String selectedLanguage = 'English';
  TextEditingController messageController = TextEditingController();
  List<String> chatMessages = [];
  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _getAndPrintLocation();
            },
          ),
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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/logo.jpeg',
                height: 100,
                width: 100,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: chatMessages.map((message) => _buildMessage(message)).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    _openCamera();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    _toggleVoiceChat();
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: isListening ? 'Listening...' : 'Type your message...',
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
    print("User: $message");
    _receiveMessage("User: $message");
    _receiveMessage("Response: Thank you for your message!");

    messageController.clear();
  }

  void _receiveMessage(String message) {
    setState(() {
      chatMessages.add(message);
    });
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final PickedFile? pickedFile = (await picker.pickImage(source: ImageSource.camera)) as PickedFile?;

    if (pickedFile != null) {
      _receiveMessage("User sent an image: ${pickedFile.path}");
    }
  }

  void _toggleVoiceChat() async {
  if (isListening) {
    speech.stop();
    setState(() {
      isListening = false;
      messageController.text = 'Type your message...'; // Set the text field indicator back to default
    });
  } else {
    bool available = await speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) {
        print('onError: $val');
        setState(() {
          isListening = false;
          messageController.text = 'Type your message...'; // Update text field indicator on error
        });
      },
    );

    if (available) {
      setState(() {
        isListening = true;
        messageController.text = 'Listening...'; // Update text field indicator
      });

      speech.listen(
        onResult: (val) {
          print('onResult: ${val.recognizedWords}');
          // You can add logic to handle recognized words if needed
          messageController.text = val.recognizedWords; // Update text field with recognized words
        },
        cancelOnError: true,
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }
}


}
