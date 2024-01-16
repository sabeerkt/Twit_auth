// import 'package:chats/model/model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:google_sign_in/google_sign_in.dart';

// class AuthServicesGithub {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   signInWithGithub() async {
//     GithubAuthProvider githubAuthProvider = GithubAuthProvider();
//     try {
//       UserCredential user =
//           await firebaseAuth.signInWithProvider(githubAuthProvider);
//       User gituser = user.user!;
//       final UserAuthentication userdata = UserAuthentication(
//           email: gituser.email, name: gituser.displayName, uid: gituser.uid);
//       firestore.collection("users").doc(gituser.uid).set(userdata.toJson());
//       return user;
//     } catch (e) {
//       // ScaffoldMessenger.of(context)
//       //     .showSnackBar(SnackBar(content: Text(e.toString())));
//       throw Exception(e);
//     }
  
//   }
// }
