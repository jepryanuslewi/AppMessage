import 'package:app_message/pages/login_page.dart';
import 'package:app_message/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // inisialisasi, tampilkan login page
  bool isLogin = true;

  void toggleLoginOrRegister() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginPage(onTap: () => toggleLoginOrRegister());
    } else {
      return RegisterPage(onTap: () => toggleLoginOrRegister());
    }
  }
}
