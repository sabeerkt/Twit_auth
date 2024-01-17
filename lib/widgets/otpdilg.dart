import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Enter OTP"),
      content: Column(
        children: <Widget>[
          Lottie.asset(
            'assets/otppss.json', // Replace with the path to your Lottie animation file
            height: 100, // Adjust the height as needed
            width: 100, // Adjust the width as needed
          ),
          SizedBox(height: 16),
          TextField(
            controller: codeController,
            decoration: InputDecoration(
              labelText: 'OTP',
              hintText: 'Enter OTP',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: Text("Done"),
        ),
      ],
    ),
  );
}
