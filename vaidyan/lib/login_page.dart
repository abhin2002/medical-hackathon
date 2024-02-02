// login_page.dart

import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'test_page.dart'; // Import the test page

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
Widget build(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  return Scaffold(
    appBar: AppBar(
      // title: const Text('Medical App Login'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Image.asset(
              'assets/logo.jpeg',
              width: 250,
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              // Handle login logic here
              String email = emailController.text;
              String password = passwordController.text;

              print('Email: $email');
              print('Password: $password');

              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestPage()),
                );
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              // Navigate to Sign Up Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            child: const Text('New user? Sign Up'),
          ),
        ],
      ),
    ),
  );
}

}
