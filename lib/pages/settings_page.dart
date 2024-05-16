import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penny/pages/about_page.dart';
import 'package:penny/pages/username_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _usernameController = TextEditingController();
  String _displayedUsername = '';
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final isDarkMode =
        prefs.getBool('isDarkMode') ?? false;
    setState(() {
      _displayedUsername = username ?? '';
      _usernameController.text = username ?? '';
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              'Username',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(_displayedUsername),
            trailing: const Icon(Icons.edit),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UsernamePage()),
            ),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (value) => setState(() => _isDarkMode = value),
          ),
          ListTile(
            title: const Text(
              'About',
              style: TextStyle(color: Colors.black),
            ),
            trailing: const Icon(Icons.info_outline),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            ),
          ),
        ],
      ),
    );
  }
}
