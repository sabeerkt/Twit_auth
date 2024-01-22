import 'package:chats/constant/const.dart';
import 'package:chats/controller/auth_provider.dart';
import 'package:chats/views/register.dart';
import 'package:chats/widgets/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chats/widgets/textform.dart';
import 'package:chats/widgets/button.dart';
import 'package:chats/widgets/tile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, required void Function() onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthPro>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/login.json', // Replace with the path to your Lottie animation file
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 10),
                        const Text(
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
                          controller: provider.usernameController,
                        ),
                        TextForm(
                          hinttext: 'Password',
                          obscureText: true,
                          controller: provider.passwordController,
                        ),
                        const SizedBox(height: 10),

                        const SizedBox(height: 10),
                        Button(
                          name: "sign",
                          onTap: () async {
                            String username =
                                provider.usernameController.text.trim();
                            String password =
                                provider.passwordController.text.trim();

                            if (username.isEmpty || password.isEmpty) {
                              // Show an alert if email or password is not typed properly
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Incomplete Information'),
                                    content: const Text(
                                        'Please enter both username and password.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              try {
                                UserCredential userCredential =
                                    await provider.signInWithEmailandPassword(
                                        username, password);

                                // Do something with userCredential if needed

                                // User exists, clear controllers
                                provider.passwordController.clear();
                                provider.usernameController.clear();
                              } catch (e) {
                                // Show an alert that the user does not exist
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('User Not Found'),
                                      content: const Text(
                                          'The entered username or password is incorrect.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                        ),

                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await provider.signInWithGoogle();
                              },
                              child: const SqureTile(
                                  imagePath: "assets/googlleee.png"),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                provider.signInWithGithub(context);
                              },
                              child:
                                  const SqureTile(imagePath: "assets/GITT.png"),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const PhoneSignIn()));
                              },
                              child: const SqureTile(
                                  imagePath: "assets/one-time-password.png"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Don't have an account? Create one",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Add some space after the text
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
                              "Register Now",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
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
