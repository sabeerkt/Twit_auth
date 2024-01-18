import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onTap;

  const DeleteButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 212, 205, 205).withOpacity(0.7),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 24.0,
        ),
      ),
    );
  }
}
