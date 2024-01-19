class Mesaage {
  String? id;
  String? message;
  String? email;

  Mesaage({
    this.id,
    this.message,
    this.email,
  });

  factory Mesaage.fromJson(String id, Map<String, dynamic> json) {
    return Mesaage(
      id: id,
      email: json['UserEmail'],
      message: json['message'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'UserEmail': email,
      'message': message,
    };
  }
}
