class Mesaage {
  String? message;
  String? email;
  Mesaage({
    this.message,
    this.email,
  });
  factory Mesaage.fromJson(Map<String, dynamic> json) {
    return Mesaage(email: json['UserEmail'], message: json['message']);
  }
  Map<String, dynamic> tojson() {
    return {
      'UserEmail': email,
      'message': message,
    };
  }
}
