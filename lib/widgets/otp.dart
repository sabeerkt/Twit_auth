import 'package:chats/services/firbase_auth.dart';
import 'package:chats/widgets/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({super.key});

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  void phoneSignIn() {
    FirebaseAuthMethods(FirebaseAuth.instance)
        .phoneSignIn(context, phoneController.text);
  }

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add Image widget here
          Lottie.asset(
            'assets/otp.json', // Replace with the actual path or asset name
          ),
          SizedBox(height: 20), // Add some space between image and text field
          // Text field goes below the image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20), // Add some space between text field and button
          ElevatedButton(
            onPressed: () {
              phoneSignIn();
            },
            child: Text("Sent OTP"),
          ),
        ],
      ),
    );
  }
}
