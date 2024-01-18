

import 'package:chats/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthPro extends ChangeNotifier {
  AuthServices authservices = AuthServices();
  String? otpcode;

 final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final Confpasswordcontroller = TextEditingController();

  bool showLoginPage = true;
  final isGoogleLoading=false;
  //instance of auth

  User? _user;

  AuthProvider() {
    authservices.firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }
  User? get user => _user;

  void togglepages() {
    showLoginPage = !showLoginPage;
    notifyListeners();
  }

//sign user out
  Future<void> signOut() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
     FirebaseAuth.instance.signOut();
    
  }
  

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    return authservices.signInWithEmailandPassword(email, password);
  }

//create a new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    return authservices.signUpWithEmailandPassword(email, password);
  }


   //google sign in
  Future<UserCredential> signInWithGoogle()async{
    return authservices.signInWithGoogle();
  }

  signInWithGithub(context) {
    return authservices.signInWithGithub(context);
  }
   otpSetter(value) {
    otpcode = value;
    notifyListeners();
  }
}

