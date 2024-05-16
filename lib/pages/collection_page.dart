import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penny/pages/camera_page.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> collectedMachines = [];
  List<Map<String, dynamic>> displayedMachines = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _fetchCollectedMachines();
  }

  Future<void> _fetchCollectedMachines() async {
    final userEmail = await _getUserEmail();
    if (userEmail == null) return;

    final snapshot = await _firestore
        .collection('collected')
        .where('user_email', isEqualTo: userEmail)
        .get();

    collectedMachines = snapshot.docs.map((doc) => doc.data()).toList();
    displayedMachines = collectedMachines;
    setState(() {});
  }

  Future<String?> _getUserEmail() async {
    final user = _auth.currentUser;
    return user?.email;
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      searchText = text;
      displayedMachines = collectedMachines
          .where((machine) =>
              machine['machine_id']
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              (machine['name']?.toString().toLowerCase() ?? '')
                  .contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search Machines...',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: _onSearchTextChanged,
              ),
            ),
            Expanded(
              child: displayedMachines.isEmpty
                  ? const Center(child: Text('No collected machines yet'))
                  : ListView.builder(
                      itemCount: displayedMachines.length,
                      itemBuilder: (context, index) {
                        final machine = displayedMachines[index];
                        return ListTile(
                          title:
                              Text(machine['machine_id'] ?? 'Unknown machine'),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CameraScreen(machine: machine),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
