// helper_page.dart

import 'package:flutter/material.dart';

class HelperPage extends StatelessWidget {
  const HelperPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Helper'),
      ),
      body: Center(
        child: Text(
          'This is the Emergency Helper Page.',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
