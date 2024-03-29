import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chats/controller/auth_provider.dart';
import 'package:chats/controller/posts_provider.dart';
import 'package:chats/model/msg.dart';
import 'package:chats/services/database_service.dart';
import 'package:chats/widgets/textform.dart';
import 'package:chats/widgets/wall_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthPro>(context, listen: false);
    final currentUser = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text(
            "Twit",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                authProvider.signOut();
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
            // Display user information
            if (currentUser != null)
              Card(
                elevation: 8, // Set the elevation value as needed
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Logged in as: ${currentUser.email}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            Expanded(
              child: StreamBuilder<QuerySnapshot<Mesaage>>(
                stream: DataBaseService().getDataOrderByTimestamp(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final List<Mesaage> posts = snapshot.data!.docs
                      .map(
                        (doc) => doc.data(),
                      )
                      .toList();

                  final List<Mesaage> validPosts = posts
                      .where((post) =>
                          post.email != null && post.email!.isNotEmpty)
                      .toList();

                  return ListView.builder(
                    itemCount: validPosts.length,
                    itemBuilder: (context, index) {
                      Mesaage post = validPosts[index];

                      return Post(
                        msg: post.message ?? '',
                        userEmail: post.email ?? '',
                        index: index,
                        postid: post.id ?? "",
                        Likes: post.Likes ?? [],
                        timestamp: post.timestamp,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Expanded(
                    child: TextForm(
                      controller:
                          Provider.of<PostProvider>(context).textcontroller,
                      hinttext: "Write",
                      obscureText: true,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final postsProvider =
                          Provider.of<PostProvider>(context, listen: false);

                      if (postsProvider.textcontroller.text.trim().isNotEmpty) {
                        postsProvider.addPost(
                          FirebaseAuth.instance.currentUser!.email ?? "",
                          postsProvider.textcontroller.text,
                        );
                        postsProvider.textcontroller.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please enter a message before posting.'),
                          ),
                        );
                      }
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
