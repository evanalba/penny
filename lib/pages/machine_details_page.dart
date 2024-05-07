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
                  const SizedBox(
                      width: 8.0),
                  Text('${machine['phone'] ?? 'None'}'),
                ],
              ),
              const SizedBox(height: 8.0),
              Text('${machine['bio'] ?? ''}'),
              const SizedBox(height: 16.0),

              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8.0),
                  child: Image.network(
                    machine['imageUrl'] ?? '',
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('Error loading image'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
