import 'package:chats/model/model.dart';
import 'package:chats/widgets/otpdilg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  String collection = 'User Post';
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

// sign user in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    }
    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//create a new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthMultiFactorException catch (e) {
      throw Exception(e.code);
    }
  }

  //google sign in
 Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  UserCredential user =
      await FirebaseAuth.instance.signInWithCredential(credential);
  User? guser = user.user;
  final UserAuthentication userdata = UserAuthentication(
      name: guser?.displayName, email: guser?.email, uid: guser?.uid);
  firestore.collection(collection).doc(guser?.uid).set(userdata.toJson());
  return user;
}


  signInWithGithub(context) async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    try {
      UserCredential user = await firebaseAuth.signInWithProvider(githubAuthProvider);
      User gituser = user.user!;
      final UserAuthentication userdata = UserAuthentication(
          email: gituser.email, name: gituser.displayName, uid: gituser.uid);
      firestore.collection(collection).doc(gituser.uid).set(userdata.toJson());
      return user;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e);
    }
  }



  void signInwithPhone(
      String phonenumber, context, String name, String email) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phonenumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            var cred = await firebaseAuth.signInWithCredential(phoneAuthCredential);
            final UserAuthentication userdata = UserAuthentication(
                email: email,
                name: name,
                uid: cred.user!.uid,
                phoneNumber: cred.user!.phoneNumber);
            firestore
                .collection(collection)
                .doc(cred.user!.uid)
                .set(userdata.toJson());
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, resendtoken) {
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  veridicationId: verificationId,
                );
              },
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  void verifyOtp(
      {required String verificationId,
      required String otp,
      required Function onSuccess}) async {
    try {
      PhoneAuthCredential cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      User? user = (await firebaseAuth.signInWithCredential(cred)).user;

      if (user != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
