
import 'package:chats/views/home.dart';
import 'package:chats/widgets/button.dart';
import 'package:chats/widgets/textform.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.white],
            begin: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
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
            SizedBox(
              height: 40,
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
                      SizedBox(
                        height: 40,
                      ),
                      TextForm(
                        hinttext: 'Username',
                        obscureText: true,
                        controller: widget.usernamecontroller,
                      ),
                      TextForm(
                        hinttext: 'Password',
                        obscureText: true,
                        controller: widget.passwordcontroller,
                      ),
                      TextForm(
                        hinttext: 'Confirm Password',
                        obscureText: true,
                        controller: widget.passwordcontroller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Button(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
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
