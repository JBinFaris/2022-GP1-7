// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel2 mongoDbMode2lFromJson(String str) => MongoDbModel2.fromJson(json.decode(str));

String mongoDbModel2ToJson(MongoDbModel2 data) => json.encode(data.toJson());

class MongoDbModel2 {
    MongoDbModel2({
        required this.id,
        required this.username,
        required this.email,
        required this.password,
        required this.phone,
        required this.userType,
    });

    ObjectId id;
    String username;
    String email;
    String password;
    String phone;
    String? userType;

    factory MongoDbModel2.fromJson(Map<String, dynamic> json) => MongoDbModel2(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        userType: json["userType"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
        "userType": userType,
    };
}
