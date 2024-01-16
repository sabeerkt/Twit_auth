import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String msg;
  final String userEmail;

  Post({Key? key, required this.msg, required this.userEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate a random color for each post
    final randomColor = Colors.primaries[
        DateTime.now().microsecondsSinceEpoch % Colors.primaries.length];

    return Container(
      decoration: BoxDecoration(
        color: randomColor, // Use the generated random color
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 24,
                color: Colors.white, // Icon color
              ),
              SizedBox(width: 8),
              Text(
                msg,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            userEmail,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[200], // Text color
            ),
          ),
        ],
      ),
    );
  }
}
