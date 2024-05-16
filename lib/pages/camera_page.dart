import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CameraScreen extends StatefulWidget {
  final Map<String, dynamic> machine;

  const CameraScreen({
    super.key,
    required this.machine,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  Future<void> _removeMachine() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userEmail = await _getUserEmail();

    final query = firestore
        .collection('collected')
        .where(
          'machine_id',
          isEqualTo: widget.machine['machine_id'],
        )
        .where(
          'user_email',
          isEqualTo: userEmail,
        );

    final querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      final docRef = querySnapshot.docs[0].reference;
      await docRef.delete();
      Navigator.pop(context);
    } else {
      if (kDebugMode) {
        print("No document found for deletion");
      }
    }
  }

  Future<String?> _getUserEmail() async {
    final user = _auth.currentUser;
    return user?.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.machine['machine_id']),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library, color: Colors.black),
            onPressed: () => _getImage(ImageSource.gallery),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                color: Colors.black,
                child: const Text(
                  "Take Image from Camera",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _getImage(ImageSource.camera),
              ),
              _pickedImage != null
                  ? Image.file(_pickedImage!)
                  : Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "No Image Selected",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
              ElevatedButton(
                onPressed: _removeMachine,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black, // Set text color to white
                ),
                child: const Text("Remove"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
