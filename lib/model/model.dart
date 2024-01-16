class UserAuthentication {
  String? name;
  String? email;
  String? phoneNumber;
  String? uid;

  UserAuthentication({
    required this.name,
    required this.email,
    required this.uid,
    this.phoneNumber,
  });
  factory UserAuthentication.fromJson(Map<String, dynamic> json) {
    return UserAuthentication(
        name: json['name'],
        email: json['email'],
        uid: json['uid'],
        phoneNumber: json['phonenumber']);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'phonenumber': phoneNumber
    };
  }
}
