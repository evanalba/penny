import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penny/pages/about_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _usernameController = TextEditingController();
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
        prefs.getBool('isDarkMode') ?? false; // Default to light mode
    setState(() {
      _usernameController.text =
          username ?? ''; // Set username from prefs or empty string
      _isDarkMode = isDarkMode;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Username'),
            subtitle: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: InputBorder.none, // Remove default border
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (value) => setState(() => _isDarkMode = value),
          ),
          ListTile(
            title: const Text('About'),
            trailing: const Icon(Icons.info_outline),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            ),
          ),
          ListTile(
            title: const Text('Log Out'),
            trailing: const Icon(Icons.logout),
            onTap: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
    );
  }
}
