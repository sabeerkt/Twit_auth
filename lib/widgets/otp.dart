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
          const SizedBox(height: 20), // Add some space between image and text field
          // Text field goes below the image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20), // Add some space between text field and button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                phoneSignIn();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Change the button color as needed
                onPrimary: Colors.white, // Change the text color as needed
                padding: const EdgeInsets.all(16.0), // Add padding to the button
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Adjust the border radius
                ),
                minimumSize:
                    const Size(double.infinity, 0), // Make the button take full width
              ),
              child: const Text(
                "Sent OTP",
                style:
                    TextStyle(fontSize: 18), // Adjust the font size as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
