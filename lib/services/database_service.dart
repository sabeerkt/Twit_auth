import 'package:chats/model/msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  String collection = 'User Post';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference<Mesaage> messageref;
  DataBaseService() {
    messageref=firestore.collection(collection).withConverter<Mesaage>(
          fromFirestore: (snapshot, options) =>
              Mesaage.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
  }
  // Stream<QuerySnapshot<Mesaage>> getData() async* {
  //   messageref.snapshots().map((snapshot) =>
  //       snapshot.docs.map((doc) => doc.data()).toList());
  // }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts() async {
    try {
      return await FirebaseFirestore.instance
          .collection(collection)
          .orderBy("TimeStamp", descending: false)
          .get();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addPost(String user, String message) async {
    try {
      await FirebaseFirestore.instance.collection(collection).add({
        'UserEmail': user,
        'Message': message,
        'TimeStamp': Timestamp.now(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
   void deletePost(postid) {
    //post delete
    FirebaseFirestore.instance
        .collection(collection)
        .doc(postid)
        .delete()
        .then((value) => print('Deleted'))
        .catchError((error) => print("faild to delete post:$error"));
  }

}
