import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('machines');

  List<Map<String, dynamic>>? machines;

  @override
  void initState() {
    super.initState();
    _fetchMachines();
  }

  Future<void> _fetchMachines() async {
    try {
      final snapshot = await collectionReference.get();
      setState(() {
        machines = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching machines: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: machines != null
          ? (machines!.isEmpty)
              ? const Center(child: Text('No machines found.')) // Handle empty data (optional)
              : ListView.builder(
                  itemCount: machines!.length,
                  itemBuilder: (context, index) {
                    final machine = machines![index];
                    return ListTile(
                      title: Text(machine['name']), // Replace 'name' with your property name
                      subtitle: Text(machine['description']), // Replace 'description' with your property name
                      // Add leading/trailing icons or other elements based on your machine data
                    );
                  },
                )
          : const Center(child: CircularProgressIndicator()), // Show loading indicator
    );
  }
}
