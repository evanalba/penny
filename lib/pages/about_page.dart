import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Virtual Pressed Penny Collector mobile application project for CINS 467 Web and Mobile App Development.',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 16.0),
            Text(
              'Developed by: Evan Alba',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
