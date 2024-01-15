import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final controller;
  final String hinttext;
  final bool obscureText;
  const TextForm(
      {super.key,
      this.controller,
      required this.hinttext,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            fillColor: const Color.fromARGB(255, 230, 219, 219),
            filled: true,
            hintText: hinttext),
      ),
    );
  }
}
