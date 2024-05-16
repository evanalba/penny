// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MachineDetailsPage extends StatefulWidget {
  final Map<String, dynamic> machine;

  const MachineDetailsPage({super.key, required this.machine});

  @override
  State<MachineDetailsPage> createState() => _MachineDetailsPageState();
}

class _MachineDetailsPageState extends State<MachineDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final machine = widget.machine;

    return Scaffold(
      appBar: AppBar(
        title: Text(machine['name']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${machine['name']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text('${machine['address']}'),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Text(
                    'Phone:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8.0),
                  Text('${machine['phone'] ?? 'None'}'),
                ],
              ),
              const SizedBox(height: 8.0),
              Text('${machine['bio'] ?? ''}'),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    machine['imageUrl'] ?? '',
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('Error loading image'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final userEmail = await getUserEmail();

                    await _firestore.collection('collected').add({
                      'machine_id': machine['name'],
                      'user_email': userEmail,
                      'collectedURL': null,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Machine collected successfully!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.black,
                  ),
                  child: const Text(
                    'Collect',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getUserEmail() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.email!;
    }
    return 'example@email.com';
  }
}
