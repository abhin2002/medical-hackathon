
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _image;
  String? _pdfPath;

  Future _getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context as BuildContext,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Choose from Gallery'),
              onTap: () {
                _getImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a Photo'),
              onTap: () {
                _getImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _signUp() async {
    // Prepare SignUp data
    final signUpData = {
      'email': _emailController.text,
      'password': _passwordController.text,
      'confirm_password': _confirmPasswordController.text,
      'mobile_number': _mobileNumberController.text,
      'facilities': _facilitiesController.text,
    };

    // Make SignUp API call
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/signup'), // Replace with your API endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(signUpData),
    );

    if (response.statusCode == 200) {
      // SignUp successful
      // You can handle the response accordingly
      print("SignUp successful");
    } else {
      // SignUp failed
      // You can handle errors or show a message to the user
      print("SignUp failed");
    }
  }

  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _facilitiesController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Profile Photo
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      )
                    : null,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _showImageSourceOptions,
                child: const Text('Upload Profile Photo'),
              ),
              const SizedBox(height: 16.0),
              // Email
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16.0),
              // Password
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16.0),
              // Confirm Password
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16.0),
              // Mobile Number
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  prefixIcon: const Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 16.0),
              // Facilities
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Facilities',
                  prefixIcon: const Icon(Icons.business),
                ),
              ),
              const SizedBox(height: 16.0),
// Upload PDF and Sign Up
Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[
    const SizedBox(width: 20.0),
    // Sign Up Button
    ElevatedButton(
      onPressed: () {
        showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Enter OTP'),
      content: PinCodeTextField(
        appContext: context,
        length: 5,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
        ),
        animationDuration: Duration(milliseconds: 300),
        onChanged: (value) {
          // Put your OTP validation logic here
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Submit'),
          onPressed: () {
            // Put your OTP submission logic here
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
);

      },
      child: const Text('Sign Up'),
    ),
    const SizedBox(width: 100.0),
    // Upload PDF
//     ElevatedButton(
//   onPressed: () async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if(result != null) {
//       PlatformFile file = result.files.first;

//       print(file.name);
//       print(file.bytes);
//       print(file.size);
//       print(file.extension);
//       print(file.path);

//       // TODO: Upload the file
//     } else {
//       // User canceled the picker
//     }
//   },
//   child: const Text('Upload PDF'),
// )


    
  ],
),

            ],
          ),
        ),
      ),
    );
  }
}