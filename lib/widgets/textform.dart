import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool obscureText;

  const TextForm({
    Key? key,
    required this.controller,
    required this.hinttext,
    required this.obscureText,
  }) : super(key: key);

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill in the field';
    }
    // Add more validation logic if needed
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        //obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: const Color.fromARGB(255, 230, 219, 219),
          filled: true,
          hintText: hinttext,
        ),
        validator: _validateInput,
      ),
    );
  }
}
