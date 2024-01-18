import 'package:chats/controller/auth_provider.dart';
import 'package:chats/controller/posts_provider.dart';
import 'package:chats/model/msg.dart'; // Import your Message class
import 'package:chats/services/database_service.dart';
import 'package:chats/widgets/textform.dart';
import 'package:chats/widgets/wall_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // final User currentUser = FirebaseAuth.instance.currentUser!;

  // void Postmsg() {
  //   if (currentUser != null && textcontroller.text.isNotEmpty) {
  //     Map<String, dynamic> postData = {
  //       "message": textcontroller.text,
  //       "timestamp": Timestamp.now(),
  //     };

  //     if (currentUser.phoneNumber != null) {
  //       postData["UserPhoneNumber"] = currentUser.phoneNumber;
  //     }

  //     if (currentUser.email != null) {
  //       postData["UserEmail"] = currentUser.email;
  //     }

  //     FirebaseFirestore.instance.collection("user post").add(postData);

  //     // Clear the text field after posting the message
  //     //textcontroller.clear();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthPro>(context, listen: false);
    final postsprovider = Provider.of<PostProvider>(context, listen: false);

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
                      // Text(
                      //   "Logged: ${ provider. currentUser.phoneNumber ??provider. currentUser.email ?? 'Unknown'}",
                      //   style: const TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //     color: Color.fromARGB(255, 255, 0, 0),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<PostProvider>(
                builder: (context, postsprovider, child) {
                  final posts = postsprovider.posts;
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
                          //postid: post.id,
                        );
                      },
                    ));
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
                      controller: postsprovider.textcontroller,
                      hinttext: "Write",
                      obscureText: true,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      postsprovider.addPost(currentUser.email!,
                          postsprovider.textcontroller.text);
                      postsprovider.textcontroller.clear();

                      ///  Postmsg();
                      // Implement sending the message
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
