import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String msg;
  final String userEmail;

  Post({Key? key, required this.msg, required this.userEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent, // Use your preferred background color
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
          Text(
            msg,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color
            ),
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
