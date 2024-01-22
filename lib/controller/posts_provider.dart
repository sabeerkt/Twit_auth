import 'package:flutter/material.dart';
import 'package:chats/model/msg.dart';
import 'package:chats/services/database_service.dart';

class PostProvider extends ChangeNotifier {
  DataBaseService postsservices = DataBaseService();
  TextEditingController textcontroller = TextEditingController();
  List<Mesaage> posts = [];

  Future<void> addPost(String user, String message) async {
    await postsservices.addPost(user, message, []);
    notifyListeners();
  }

  Future<void> deletePost(String postid) async {
    await postsservices.deletePost(postid);
    notifyListeners();
  }

  Future<void> toggleLike(String postid, bool isLiked) async {
    await postsservices.toggleLike(postid, isLiked);
    notifyListeners();
  }

 
}
