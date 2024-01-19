import 'package:chats/model/msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  String collection = 'User Post';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference<Mesaage> messageRef;

  DataBaseService() {
    messageRef = firestore.collection(collection).withConverter<Mesaage>(
      fromFirestore: (snapshot, options) =>
          Mesaage.fromJson(snapshot.id, snapshot.data()!),
      toFirestore: (value, options) => value.tojson(),
    );
  }

  Stream<QuerySnapshot<Mesaage>> getData() {
    return messageRef.snapshots().handleError((error) {
      print("Error fetching data: $error");
    });
  }

  Future<void> addPost(String user, String message, List<String> Likes) async {
    try {
      await messageRef.add(
        Mesaage(
          email: user,
          message: message,
          Likes: Likes,
        ),
      );
    } catch (e) {
      print("Error adding post: $e");
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await firestore
          .collection(collection)
          .doc(postId)
          .delete()
          .then((value) => print('Deleted'))
          .catchError((error) => print("Failed to delete post: $error"));
    } catch (e) {
      print("Error deleting post: $e");
    }
  }
}
