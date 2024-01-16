// import 'package:chats/model/model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';


// class AuthServices {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//       final GoogleSignInAuthentication gAuth = await gUser!.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: gAuth.accessToken,
//         idToken: gAuth.idToken,
//       );
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       User? googleUser = userCredential.user;
//       UserAuthentication userAuthentication = UserAuthentication(
//           name: googleUser!.displayName,
//           email: googleUser.email,
//           uid: googleUser.uid);
//       firestore
//           .collection('users')
//           .doc(googleUser.uid)
//           .set(userAuthentication.toJson());
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } catch (e) {}
//   }
// }
