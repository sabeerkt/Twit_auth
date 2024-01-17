import 'package:chats/widgets/textform.dart';
import 'package:chats/widgets/wall_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      textcontroller.clear();
    }
  }

  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                signOut();
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
                      Text(
                        "Logged: ${currentUser.phoneNumber ?? currentUser.email ?? 'Unknown'}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("user post")
                    .orderBy("timestamp", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return Post(
                          msg: post["message"] ?? '',
                          userEmail: post["UserEmail"] ?? 'Unknown',
                          index: index,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error.toString()}"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
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
                      controller: textcontroller,
                      hinttext: "Write",
                      obscureText: true,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Postmsg();
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
