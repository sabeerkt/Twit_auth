import 'package:chats/controller/auth_provider.dart';
import 'package:chats/widgets/sign_dlg.dart';
import 'package:flutter/material.dart';
import 'package:chats/views/home.dart';
import 'package:chats/widgets/button.dart';
import 'package:chats/widgets/textform.dart';

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
            colors: [Colors.deepOrange, Colors.white],
            begin: Alignment.topCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.create,
                          size: 60,
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
                          onTap: () async {
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
                              // If passwords don't match, you can show an error message or handle it as needed
                              Main_Dailog("Passwords do not match");
                            }
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
      ),
    );
  }
}
