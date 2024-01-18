import 'package:chats/auth/login_reg.dart';
import 'package:chats/controller/auth_provider.dart';
import 'package:chats/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthPro>(context,listen: false);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if logged
          if (snapshot.hasData) {
            return Home();
          } else {
            return  LoginReg();
          }
        },
      ),
    );
  }
}
