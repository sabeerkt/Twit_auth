import 'package:chats/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
 final User currentUser = FirebaseAuth.instance.currentUser!;
   DataBaseService postsservices = DataBaseService();
  //text controller
  final textcontroller = TextEditingController();

  List<DocumentSnapshot> posts = [];

  PostsProvider() {
    fetchPosts();
  }

  //Fetch posts from Firebase Firestore
  Future<void> fetchPosts() async {
    try {
      final querySnapshot = await postsservices.fetchPosts();
      posts = querySnapshot.docs;
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//add posts from firebasestore
  Future<void> addPost(String user, String message) async {
    postsservices.addPost(user, message);
    //update the post list after adding a new post
    await fetchPosts();
  }
//delete post
  Future<void> deletePost(postid) async {
    postsservices.deletePost(postid);

    await fetchPosts();
  }

 
  
}