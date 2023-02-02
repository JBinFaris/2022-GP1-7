import 'dart:core';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseFirestore _firestore2 = FirebaseFirestore.instance;

final CollectionReference _foodPostCollection =
    _firestore.collection("foodPost");
final CollectionReference _reportedContentCollection =
    _firestore2.collection("reportedContent");
final DocumentReference ref =
    FirebaseFirestore.instance.collection("reportedContent").doc();

class Database {
  final String docId;
  final String userUid;
  final String userPost;
  final String postTitle;
  final String postText;
  final String postAdress;
  final String postImage;
  final String postExp;
  final String food_cont;
  final bool providerblocked;
  String? reservedby;

  String? postUserName;

  String? postEmail;

  String? postPhone;

  Database.foodConstructor({
    required this.docId,
    required this.userUid,
    required this.userPost,
    required this.postTitle,
    required this.postText,
    required this.postAdress,
    required this.postImage,
    required this.postExp,
    required this.food_cont,
    required this.reservedby,
    required this.providerblocked,
  });

  static Future<void> addFoodPostData({
    required BuildContext context,
    required String docId,
    required String userUid,
    required String userPost,
    required String postTitle,
    required String postText,
    required String postAdress,
    required String postImage,
    required String postExp,
    required String food_cont,
    required bool providerblocked,
    String? reserve,
    String? notify,
    String? reservedby,
    String? notifyCancelP,
    String? notifyCancelC,
  }) async {
    DocumentReference documentReference = _foodPostCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'Cid': userUid.toString().trim(),
      'docId': docId.toString().trim(),
      'userPost': userPost.toString().trim(),
      'postTitle': postTitle.toString().trim(),
      'postText': postText.toString().trim(),
      'postAdress': postAdress.toString().trim(),
      "postImage": postImage.toString().trim(),
      "pathImage": "pathImage".toString().trim(),
      "postExp": postExp.toString().trim(),
      "food_cont": food_cont.toString().trim(),
      "providerblocked": providerblocked,
      "postDate": DateTime.now().toString(),
      'reserve': reserve,
      'notify': notify,
      'reservedby': reservedby,
      'notifyCancelP': notifyCancelP,
      'notifyCancelC': notifyCancelC,
    };
    await documentReference.set(data).whenComplete(() {
      print('Note item saved to the database');
      Fluttertoast.showToast(msg: "تم نشر الاعلان بنجاح");
      Navigator.pop(context);
    }).catchError((e) {
      print(e);
    });
  }
}

class Database2 {
  static Future<void> reportedContentData({
    required BuildContext context,
    Rid,
    required docId,
    required ReportReason,
    required postTitle,
    required postText,
    postImage, //
    pathImage, //
    required Cid,
    required int? flag,
  }) async {
    DocumentReference documentReference = _reportedContentCollection.doc(Rid);

    Map<String, dynamic> data = <String, dynamic>{
      'Rid': documentReference.id,
      'postId': docId.toString().trim(),
      'ReportReason': ReportReason.toString().trim(),
      'postText': postText.toString().trim(),
      'postTitle': postTitle.toString().trim(),
      "postImage": postImage.toString().trim(),
      "pathImage": "pathImage".toString().trim(),
      'userId': Cid.toString().trim(),
      "flag": flag,
    };
    await documentReference.set(data).whenComplete(() {
      print('Note item saved to the database');
      Fluttertoast.showToast(msg: "تم الإبلاغ");
      Navigator.pop(context);
    }).catchError((e) {
      print(e);
    });
  }
}
