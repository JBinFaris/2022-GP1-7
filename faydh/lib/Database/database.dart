import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _foodPostCollection =
    _firestore.collection("foodPost");

class Database {
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
    required String reserve,
    required String notify,
    required String reservedby,
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
      "postDate": DateTime.now().toString(),
      'reserve': reserve,
      'notify': notify,
      'reservedby': reservedby,
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
