
import 'package:chats/services/firbase_auth.dart';
import 'package:chats/views/home.dart';
import 'package:chats/views/signup.dart';
import 'package:chats/widgets/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signInUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: usernameController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(20),
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
                      "Sign In",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
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
                      SizedBox(height: 40),
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
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Handle forgot password
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          signInUser();
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(25),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              "sign",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      // Button(
                      //   onTap: () {

                      //     signInUser(); // Navigator.push(
                      //     //   context,
                      //     //   MaterialPageRoute(builder: (context) => Home()),
                      //     // );
                      //   },
                      // ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //SqureTile(imagePath: "assets/facebook-messenger.png"),
                          SizedBox(width: 10),
                        //  SqureTile(imagePath: "assets/facebook-messenger.png"),
                        ],
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: Container(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
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
