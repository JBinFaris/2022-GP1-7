// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
    MongoDbModel({
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

    factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
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
