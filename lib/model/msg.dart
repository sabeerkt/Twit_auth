import 'package:cloud_firestore/cloud_firestore.dart';

class Mesaage {
  String? id;
  String? message;
  String? email;
  List<String>? Likes;
  DateTime? timestamp;

  Mesaage({
    this.id,
    this.message,
    this.email,
    this.Likes,
    this.timestamp,
  });

  factory Mesaage.fromJson(String id, Map<String, dynamic> json) {
    return Mesaage(
      id: id,
      email: json['UserEmail'],
      message: json['message'],
      Likes: List<String>.from(json['Likes'] ?? []),
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'UserEmail': email,
      'message': message,
      'Likes': Likes,
      'timestamp': timestamp,
    };
  }
}
