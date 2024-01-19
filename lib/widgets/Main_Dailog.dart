import 'package:flutter/material.dart';

class Main_Dailog extends StatefulWidget {
  const Main_Dailog(String s, {Key? key}) : super(key: key);

  @override
  State<Main_Dailog> createState() => _MainDialogState();

  void show(BuildContext context) {}
}

class _MainDialogState extends State<Main_Dailog> {
  void displayDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            message,
            style: const TextStyle(
              // Customize the text style if needed
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            // Add additional actions or buttons if needed
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform any additional actions on button press
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  // Customize the button text style if needed
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Implement the widget tree for your state here
    return Container();
  }
}
