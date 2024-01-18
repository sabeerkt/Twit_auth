import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
 final User currentUser = FirebaseAuth.instance.currentUser!;
   final textcontroller = TextEditingController();

  void Postmsg() {
    if (currentUser != null && textcontroller.text.isNotEmpty) {
      Map<String, dynamic> postData = {
        "message": textcontroller.text,
        "timestamp": Timestamp.now(),
      };

      if (currentUser.phoneNumber != null) {
        postData["UserPhoneNumber"] = currentUser.phoneNumber;
      }

      if (currentUser.email != null) {
        postData["UserEmail"] = currentUser.email;
      }

      FirebaseFirestore.instance.collection("user post").add(postData);

      // Clear the text field after posting the message
      //textcontroller.clear();
    }
  }
  
}