import 'package:chats/views/login.dart';
import 'package:chats/views/register.dart';
import 'package:flutter/material.dart';

class Login_Reg extends StatefulWidget {
  const Login_Reg({Key? key}) : super(key: key);

  @override
  State<Login_Reg> createState() => _Login_RegState();
}

class _Login_RegState extends State<Login_Reg> {
  bool showLoginPage = true;

  void toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: toggle);
    } else {
      return SignUp(onTap: toggle);
    }
  }
}
