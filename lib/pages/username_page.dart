import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  final TextEditingController _usernameController = TextEditingController();
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _getFirebaseUserEmail();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    setState(() {
      _username = username;
      _usernameController.text = username;
    });
  }

  Future<void> _saveUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    setState(() {
      _username = _usernameController.text;
    });
  }

  Future<void> _getFirebaseUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      setState(() {
        _username = user.email!; // Set initial username to Firebase email
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Enter Username',
              ),
              onChanged: (value) => setState(() => _username = value),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveUsername,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Username'),
            ),
            const SizedBox(height: 16.0),
            Text('Current Username: $_username'),
          ],
        ),
      ),
    );
  }
}
