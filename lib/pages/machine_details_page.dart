import 'package:flutter/material.dart';

class MachineDetailsPage extends StatelessWidget {
  final Map<String, dynamic> machine;

  const MachineDetailsPage({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(machine['name']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${machine['name']}'),
            Text('Address: ${machine['address']}'),

          ],
        ),
      ),
    );
  }
}
