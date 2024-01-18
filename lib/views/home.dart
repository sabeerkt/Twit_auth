import 'package:chats/controller/auth_provider.dart';
import 'package:chats/controller/posts_provider.dart';
import 'package:chats/widgets/textform.dart';
import 'package:chats/widgets/wall_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthPro>(context, listen: false);
    final postsProvider = Provider.of<PostProvider>(context, listen: false);
    final currentUser = FirebaseAuth.instance.currentUser!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                provider.signOut();
              },
              icon: Image.asset(
                'assets/log-out.png',
                width: 24,
                height: 24,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 241, 241, 241).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 32,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      const SizedBox(width: 10),
                      // Add user information here if needed
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<PostProvider>(
                builder: (context, postsProvider, child) {
                  final posts = postsProvider.posts;

                  if (posts.isEmpty) {
                    return Center(child: Text('No posts available.'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          return Post(
                            msg: post['Message'],
                            userEmail: post['UserEmail'],
                            index: index,
                            postid: post.id,
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Expanded(
                    child: TextForm(
                      controller: postsProvider.textcontroller,
                      hinttext: "Write",
                      obscureText: true,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      postsProvider.addPost(
                        currentUser.email!,
                        postsProvider.textcontroller.text,
                      );
                      postsProvider.textcontroller.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
