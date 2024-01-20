import 'package:chats/controller/posts_provider.dart';
import 'package:chats/services/database_service.dart';
import 'package:chats/widgets/dlt.dart';
import 'package:chats/widgets/like.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  final String msg;
  final String userEmail;
  final int index;
  final String postid;
  final List<String> Likes;
  final DateTime? timestamp;

  Post({
    Key? key,
    required this.msg,
    required this.userEmail,
    required this.index,
    required this.postid,
    required this.Likes,
    required this.timestamp,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.Likes.contains(FirebaseAuth.instance.currentUser!.email);
    likeCount = widget.Likes.length;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final Color postColor = widget.index % 2 == 0
        ? Color.fromARGB(255, 255, 255, 255)
        : const Color.fromARGB(255, 255, 255, 255);
    String avatarLetter = widget.userEmail.isNotEmpty
        ? widget.userEmail.substring(0, 1).toUpperCase()
        : '';

    return Container(
      decoration: BoxDecoration(
        color: postColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
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
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                child: Text(
                  avatarLetter,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Name :',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 255, 8, 8),
                    ),
                  ),
                  Text(
                    widget.userEmail,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 130, 119, 119),
                    ),
                  ),
                  Text(
                    widget.timestamp != null
                        ? 'Posted on: ${DateFormat.yMMMd().add_jm().format(widget.timestamp!)}'
                        : '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 130, 119, 119),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            DataBaseService().capitalizeFirstLetter(widget.msg),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          Row(
            children: [
              Like(
                isliked: isLiked,
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                    if (isLiked) {
                      widget.Likes.add(
                          FirebaseAuth.instance.currentUser!.email!);
                    } else {
                      widget.Likes.remove(
                          FirebaseAuth.instance.currentUser!.email!);
                    }
                    likeCount = widget.Likes.length;
                  });

                  DocumentReference postref = FirebaseFirestore.instance
                      .collection('User Post')
                      .doc(widget.postid);
                  if (isLiked) {
                    postref.update({
                      'Likes': FieldValue.arrayUnion(
                          [FirebaseAuth.instance.currentUser!.email])
                    });
                  } else {
                    postref.update({
                      'Likes': FieldValue.arrayRemove(
                          [FirebaseAuth.instance.currentUser!.email])
                    });
                  }

                  Provider.of<PostProvider>(context, listen: false)
                      .toggleLike(widget.postid, isLiked);
                },
              ),
              const SizedBox(width: 8),
              Text('$likeCount likes'),
            ],
          ),
          if (currentUser.email == widget.userEmail)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DeleteButton(
                  onTap: () {
                    Provider.of<PostProvider>(context, listen: false)
                        .deletePost(widget.postid);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
