import 'package:app_message/component/my_button.dart';
import 'package:app_message/component/my_text_field.dart';
import 'package:app_message/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  final inputEmail = TextEditingController();

  final inputPassword = TextEditingController();

  void login(BuildContext context) async {
    // auth service
    final auth = AuthService();
    try {
      await auth.signInWithEmailPassword(inputEmail.text, inputPassword.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
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
                Icon(
                  Icons.message_outlined,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                // Say Text
                Padding(
                  padding: const EdgeInsets.only(bottom: 50, top: 10),
                  child: Text(
                    'Welcome To ChatApp, Login Now!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Email Input
                MyTextField(controller: inputEmail, text: 'Email'),
                // Password Input
                MyTextField(controller: inputPassword, text: 'Password'),

                // forget password
                Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50),

                // singin button
                MyButton(onTap: () => login(context), text: 'Login'),

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
                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 16),
                    ),

                    TextButton(
                      onPressed: onTap,
                      child: Text(
                        'Register Now',
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
