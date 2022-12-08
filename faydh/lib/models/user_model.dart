import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String role;
  final String email;
  final String uid;
  final String username;
  final String phoneNumber;

  User({
    required this.email,
    required this.role,
    required this.uid,
    required this.phoneNumber,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "phoneNumber": phoneNumber,
        "email": email,
        "role": role,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      role: snapshot["role"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      phoneNumber: snapshot["phoneNumber"]);
  }
}
