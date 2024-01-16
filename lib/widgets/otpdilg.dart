import 'package:flutter/material.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onpressed,
}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Enter OTP"),
            content: Column(children: <Widget>[
              TextField(
                controller: codeController,
              )
            ]),
            actions: <Widget>[
              TextButton(onPressed: onpressed, child: Text("Done")),
            ],
          ));
}