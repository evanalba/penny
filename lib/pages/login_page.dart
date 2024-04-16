import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // final userController = TextEditingController();
  // final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(height: 50),

            // Logo
            Text(
              'Penny',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Username
            // Password
            // Forgot Password
            // Sign In Button
            // Or Continue with
            // Google Sign in Button
            // Not a member? Register Now!
          ]),
        ),
      ),
    );
  }
}
