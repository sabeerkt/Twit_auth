import 'package:chats/model/msg.dart';
import 'package:chats/services/database_service.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  DataBaseService postsservices = DataBaseService();
  TextEditingController textcontroller = TextEditingController();
  List<Mesaage> posts = [];

  // PostProvider() {
  //   fetchPosts();
  // }

  // Future<void> fetchPosts() async {
  //   try {
  //     final List<Mesaage> fetchedPosts = await postsservices.fetchPosts();
  //     posts = fetchedPosts;
  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  Future<void> addPost(String user, String message) async {
    await postsservices.addPost(user, message);
  }

  Future<void> deletePost(String postid) async {
    await postsservices.deletePost(postid);
  }
}
