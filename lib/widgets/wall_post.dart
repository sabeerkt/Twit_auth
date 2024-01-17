import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String msg;
  final String userEmail;
  final int index;

  Post(
      {Key? key,
      required this.msg,
      required this.userEmail,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the index
    final Color postColor = index % 2 == 0 ? Colors.blue : Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: postColor, // Use the determined color
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person,
                size: 24,
                color: Color.fromARGB(255, 20, 20, 20), // Icon color
              ),
              const SizedBox(width: 8),
              Text(
                userEmail,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0), // Text color
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            msg,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[200], // Text color
            ),
          ),
        ],
      ),
    );
  }
}
