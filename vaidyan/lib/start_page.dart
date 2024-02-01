// start_page.dart

import 'package:flutter/material.dart';
import 'login_page.dart'; // Import your login page here
import 'helper_page.dart'; // Import your helper page here

class StartPage extends StatelessWidget {
  const StartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Medical App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Image.asset(
                  'assets/logo.jpeg', // Replace with your logo asset path
                  width: 250, // Adjust the width as needed
                ),
              ),
              // Introduction Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'vAIdyan is a platform which gives advice on how to provide first aid in an emergency situation with the available materials and provide assistance in taking the patient to the nearby hospital.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Choose an option below to get started:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              // Buttons
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to Hospital Page or implement hospital logic
                  // For now, navigate to login page as an example
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                icon: Icon(Icons.local_hospital),
                label: const Text('Hospital'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to First Aid Page or implement first aid logic
                  // For now, navigate to login page as an example
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelperPage()),
                  );
                },
                icon: Icon(Icons.medical_services), // Using a medical emergency help icon
                label: const Text('Emergency Help'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
