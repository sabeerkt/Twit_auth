import 'package:chats/constant/const.dart';
import 'package:chats/controller/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:chats/views/home.dart';
import 'package:chats/widgets/button.dart';
import 'package:chats/widgets/textform.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key, required void Function() onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const SizedBox(width: 100),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/regis.json',
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Consumer<AuthPro>(
                  builder: (context, value, child) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextForm(
                          hinttext: 'Username',
                          obscureText: true,
                          controller: value.usernameController,
                        ),
                        TextForm(
                          hinttext: 'Password',
                          obscureText: true,
                          controller: value.passwordController,
                        ),
                        TextForm(
                          hinttext: 'Confirm Password',
                          obscureText: true,
                          controller: value.Confpasswordcontroller,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Button(
                          name: "Register",
                          onTap: () async {
                            // Check if any field is empty
                            if (value.usernameController.text.isEmpty ||
                                value.passwordController.text.isEmpty ||
                                value.Confpasswordcontroller.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: const Text(
                                        "All fields must be filled out."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }

                            // Check if the password and confirmation password match
                            if (value.passwordController.text ==
                                value.Confpasswordcontroller.text) {
                              try {
                                // If they match, call the signUpWithEmailandPassword method
                                await value.signUpWithEmailandPassword(
                                  value.usernameController.text,
                                  value.passwordController.text,
                                );
                                value.usernameController.clear();
                                value.passwordController.clear();
                                value.Confpasswordcontroller.clear();

                                // Navigate to the home screen after successful account creation
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              } catch (e) {
                                // Handle any errors that occur during account creation
                                print("Error creating account: $e");
                              }
                            } else {
                              // If passwords don't match, show an error message
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content:
                                        const Text("Passwords do not match."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Button(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          name: "Back",
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
