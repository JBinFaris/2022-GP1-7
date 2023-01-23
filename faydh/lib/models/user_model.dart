
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String role;
  final String email;
  final String uid;
  final String username;
  final String phoneNumber;
  final String? crNo;
  final String? status;
  final String? crNoExpDate;
  int ReportCount; //= 0;
  bool Active ;

  User({
    required this.email,
    required this.role,
    required this.uid,
    required this.phoneNumber,
    required this.username,
    this.crNo,
    this.status,
    this.crNoExpDate,
    this.ReportCount = 0 ,
    this.Active = true ,

  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "phoneNumber": phoneNumber,
        "email": email,
        "role": role,
        if (role == "منظمة تجارية") "crNo": crNo,
        if (role == "منظمة تجارية") "status": "0",
        if (role == "منظمة تجارية")
          "crNoExpDate": crNoExpDate.toString().trim(),

      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        username: snapshot["username"],
        role: snapshot["role"],
        uid: snapshot["uid"] ?? '',
        email: snapshot["email"],
        phoneNumber: snapshot["phoneNumber"],
        ReportCount: snapshot["ReportCount"],
        crNo: snapshot["crNo"],
        status: snapshot["status"],
        crNoExpDate: snapshot["crNoExpDate"],
        Active: snapshot["Active"]);
  }
}
