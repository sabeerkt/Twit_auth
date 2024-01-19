class Mesaage {
  String? id;
  String? message;
  String? email;
  List<String>? Likes;

  Mesaage({
    this.id,
    this.message,
    this.email,
    this.Likes,
  });

  factory Mesaage.fromJson(String id, Map<String, dynamic> json) {
    return Mesaage(
      id: id,
      email: json['UserEmail'],
      message: json['message'],
      Likes: List<String>.from(json['Likes'] ?? []),
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'UserEmail': email,
      'message': message,
      'Likes': Likes,
    };
  }
}
