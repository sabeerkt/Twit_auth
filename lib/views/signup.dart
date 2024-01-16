import 'package:chats/services/firbase_auth.dart';
import 'package:chats/views/home.dart';
import 'package:chats/widgets/button.dart';
import 'package:chats/widgets/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key, required void Function() onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final Confpasswordcontroller = TextEditingController();
  void signUp() async {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  if (passwordController.text != Confpasswordcontroller.text) {
    Navigator.pop(context);
    displaydlg("Passwords do not match");
    return;
  }
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text, password: passwordController.text)
        .then((userCredential) {
          Navigator.pop(context); // Dismiss the loading dialog
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        });
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    displaydlg(e.code);
  }
}


  void displaydlg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  // void signInUser() {
  //   FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
  //       email: usernameController.text,
  //       password: passwordController.text,
  //       context: context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.white],
            begin: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.create,
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      TextForm(
                        hinttext: 'Username',
                        obscureText: true,
                        controller: usernameController,
                      ),
                      TextForm(
                        hinttext: 'Password',
                        obscureText: true,
                        controller: passwordController,
                      ),
                      TextForm(
                        hinttext: 'Confirm Password',
                        obscureText: true,
                        controller: Confpasswordcontroller,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Button(
                        onTap: () {
                          signUp();
                          // signInUser();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Home()),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
