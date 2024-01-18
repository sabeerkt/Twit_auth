import 'package:chats/widgets/dlt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chats/controller/posts_provider.dart';

class Post extends StatelessWidget {
  final String msg;
  final String userEmail;
  final int index;
  final String postid;

  Post({
    Key? key,
    required this.msg,
    required this.userEmail,
    required this.index,
    required this.postid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final Color postColor = index % 2 == 0 ? Colors.blue : Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: postColor,
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 24,
                    color: Color.fromARGB(255, 20, 20, 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    userEmail,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                msg,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
          if (currentUser.email == userEmail)
            Positioned(
              top: 0,
              right: 0,
              child: DeleteButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Post'),
                      content: const Text(
                        'Are you sure you want to delete this post?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            Provider.of<PostProvider>(context, listen: false)
                                .deletePost(postid);

                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
