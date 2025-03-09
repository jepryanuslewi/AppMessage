import 'package:app_message/component/my_button.dart';
import 'package:app_message/component/my_text_field.dart';
import 'package:app_message/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final inputEmail = TextEditingController();
  final inputPassword = TextEditingController();

  // sign up
  void register(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signUpWithEmailPassword(
        inputEmail.text,
        inputPassword.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Logo
                Icon(Icons.message_outlined, size: 100),

                // Say Text
                Padding(
                  padding: const EdgeInsets.only(bottom: 50, top: 10),
                  child: Text(
                    'Welcome To ChatApp, Login Now!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                // Email Input
                MyTextField(controller: inputEmail, text: 'Email'),

                // Password Input
                MyTextField(controller: inputPassword, text: 'Password'),

                // password confirmation
                MyTextField(controller: inputPassword, text: 'Password'),

                SizedBox(height: 50),

                // Register button
                MyButton(onTap: () => register(context), text: 'Register'),

                SizedBox(height: 20),

                // continue with google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(child: Divider(thickness: 2)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or Continue With',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(child: Divider(thickness: 2)),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Continue with google
                Icon(Icons.lock, size: 40),

                SizedBox(height: 50),
                // Login Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: widget.onTap,
                      child: Text(
                        'Login Now',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
