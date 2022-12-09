import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String role;
  final String email;
  final String uid;
  final String username;
  final String phoneNumber;
  final String? regNo;
  final String? status;

  User({
    required this.email,
    required this.role,
    required this.uid,
    required this.phoneNumber,
    required this.username,
    this.regNo,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "phoneNumber": phoneNumber,
        "email": email,
        "role": role,
        if (role == "منظمة تجارية") "regNo": regNo,
        if (role == "منظمة تجارية") "status": "0",
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      role: snapshot["role"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      phoneNumber: snapshot["phoneNumber"],
      regNo: snapshot["regNo"],
      status: snapshot["status"],
    );
  }
}
