import 'package:chats/auth/github.dart';
import 'package:chats/auth/google_sign.dart';
import 'package:chats/views/signup.dart';
import 'package:chats/widgets/button.dart';
import 'package:chats/widgets/otp.dart';
import 'package:chats/widgets/textform.dart';
import 'package:chats/widgets/tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required void Function() onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      displayDialog(e.message ?? "Login failed");
    } finally {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  void displayDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
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
                          "Login In",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
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
                        const SizedBox(height: 40),
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle forgot password
                                },
                                child: const Text(
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
                        const SizedBox(height: 10),
                        Button(
                          onTap: signIn,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                signInWithGoogle();
                              },
                              child: const SqureTile(
                                  imagePath: "assets/google.png"),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                //  AuthServicesGithub().signInWithGithub();
                              },
                              child: const SqureTile(
                                  imagePath: "assets/github.png"),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => PhoneSignIn()));
                              },
                              child:
                                  const SqureTile(imagePath: "assets/otp.png"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(
                                  onTap: () {},
                                ),
                              ),
                            );
                          },
                          child: Container(
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
