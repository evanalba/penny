import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      if (kDebugMode) {
        print('Image selected from $source: ${image.path}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Pick Image from Gallery",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => _getImage(ImageSource.gallery),
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Pick Image from Camera",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => _getImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }
}
