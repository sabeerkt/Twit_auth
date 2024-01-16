
// import 'package:chats/widgets/snackbar.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';

// class FirebaseAuthMethods {
//   final FirebaseAuth _auth;
//   FirebaseAuthMethods(this._auth);

//   //Email sign in

//   Future<void> signUpWithEmail({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       showSnackbar(context, e.message!);
//       print(e.message!);
//     }
//   }

//   //login
// Future<void> loginWithEmail({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       if (!_auth.currentUser!.emailVerified) {
//         await sendEmailVerification(context);
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnackbar(context, e.message!);
//     }
//   }
// //send email verification
//   Future<void> sendEmailVerification(BuildContext context) async {
//     try {
//       _auth.currentUser!.sendEmailVerification();
//       showSnackbar(context, "Email verification sent");
//     } on FirebaseAuthException catch (e) {
//       showSnackbar(context, e.message!);
//     }
//   }
// }

