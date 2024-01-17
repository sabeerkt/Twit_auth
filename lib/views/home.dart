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
    if (textcontroller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("user post").add({
        "UserEmail": currentUser.email,
        "message": textcontroller.text,
        "timestamp": Timestamp.now(),
      });

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
    return Scaffold(
      //backgroundColor: Colors.grey,
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
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue, // Add your desired background color
              borderRadius:
                  BorderRadius.circular(10), // Optional: Add rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.account_circle, // Add an icon for a user profile
                  size: 32,
                  color: Colors.white,
                ),
                const SizedBox(
                    width: 10), // Add some spacing between icon and text
                Text(
                  "Logged : ${currentUser.email}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ],
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
                        msg: post["message"],
                        userEmail: post["UserEmail"],
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
    );
  }
}
