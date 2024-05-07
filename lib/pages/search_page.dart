import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'machine_details_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('machines');
  List<Map<String, dynamic>>? allMachines;
  List<Map<String, dynamic>>? machines;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _fetchMachines();
  }

  Future<void> _fetchMachines() async {
    try {
      final snapshot = await collectionReference.get();
      setState(() {
        allMachines = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList()
          ..sort((a, b) => a['name'].compareTo(b['name']));
        machines = allMachines;
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching machines: $error");
      }
    }
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      searchText = text;
      if (text.isEmpty) {
        machines = allMachines;
      } else {
        machines = allMachines
            ?.where((machine) =>
                machine['name'].toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
    });
  }

  void _navigateToDetailsPage(Map<String, dynamic> machine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MachineDetailsPage(machine: machine),
      ),
    );
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
              child: machines != null
                  ? (machines!.isEmpty)
                      ? const Center(child: Text('No machines found.'))
                      : ListView.builder(
                          itemCount: machines!.length,
                          itemBuilder: (context, index) {
                            final machine = machines![index];
                            return ListTile(
                              title: Text(machine['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(machine['address']),
                                  Text(
                                    'Status: ${machine['status']}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              onTap: () => _navigateToDetailsPage(machine),
                            );
                          },
                        )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
