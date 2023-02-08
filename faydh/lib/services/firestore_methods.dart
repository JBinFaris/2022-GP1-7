import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/models/post_model.dart';
import 'package:faydh/models/reported_model.dart';
import 'package:faydh/models/user_model.dart' as user1;
import 'package:faydh/services/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DocumentReference ref =
      FirebaseFirestore.instance.collection("posts").doc();
  final DocumentReference ref2 =
      FirebaseFirestore.instance.collection("reportedContent").doc();

  // Uplaod the post::
  Future<String> uploadPost({
    Cid,
    //required String postUserName,
    required String postText,
    required DateTime postDate,
    Uint8List? file, //
  }) async {
    String res = "Some error occured";

    try {
      Map<String, String> photoUrl = {};
      if (file != null) {
        photoUrl = await StorageMethods()
            .uploadImageToStorage("postsImage", file, true);
      }
      String userId = _auth.currentUser!.uid;

      Posts post = Posts.postConstructor(
          ref.id,
          postText,
          photoUrl['downloadUrl'] ?? '',
          photoUrl['path'] ?? '',
          userId,
          postDate);

      var a = await _firestore.collection("posts").add(post.toJson());
      var docId = a.id;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(docId)
          .update({'Cid': docId});
      print(docId);

      res = "succces";
    } catch (err) {
      res = err.toString();
      log(res);
    }
    return res;
  }

  Future<String> updatePostTwo({
    required String title,
    required String? oldImage,
    required String id,
    Uint8List? file,
    required DocumentReference<Map<String, dynamic>> reference,
  }) async {
    String res = "Some error occurred";
    try {
      Map<String, String> photoUrl = {};
      if (file != null) {
        photoUrl = await StorageMethods()
            .uploadImageToStorage("postsImage", file, true, filename: oldImage);
      }

      Map<String, String> values = {"postText": title};
      if (photoUrl.containsKey('downloadUrl') &&
          photoUrl['downloadUrl']!.isNotEmpty) {
        values.putIfAbsent('postImage', () => photoUrl['downloadUrl']!);
        values.putIfAbsent('pathImage', () => photoUrl['path']!);
      }
      await reference.update(values).then((value) {
        res = "success";
      });
    } catch (e) {
      log(e.toString());
    }
    return res;
  }

  Future<String> updatePostThree({
    required String title,
    required String? oldImage,
    required String id,
    required String address,
    required String text,
    required String count,
    required String expireDate,
    Uint8List? file,
    required DocumentReference<Map<String, dynamic>> reference,
  }) async {
    String res = "Some error occurred";
    try {
      Map<String, String> photoUrl = {};
      if (file != null) {
        photoUrl = await StorageMethods()
            .uploadImageToStorage("postsImage", file, true, filename: oldImage);
      }
      Map<String, String> values = {
        "postTitle": title,
        "postAdress": address,
        "postText": text,
        "food_cont": count,
        "postExp": expireDate,
      };
      if (photoUrl.containsKey('downloadUrl') &&
          photoUrl['downloadUrl']!.isNotEmpty) {
        values.putIfAbsent('postImage', () => photoUrl['downloadUrl']!);
        values.putIfAbsent('pathImage', () => photoUrl['path']!);
      }
      await reference.update(values).then((value) {
        res = "success";
      });
    } catch (e) {
      log(e.toString());
    }
    return res;
  }

  Future<String> uploadReport({
    Rid,
    ReportReason,

    //required String postUserName,
    String? postText,
    String? pathImage,
    String? postImage,
    required String userId,
    String? postId,
    int? flag,
     required List<String> Reporters ,
      required final int reportCount ,

    //Uint8List? file, //
  }) async {
    String res = "Some error occured";

    try {
      reported report = reported.ReportedConstructor(ref2.id, ReportReason, postId, Reporters, reportCount,postText, pathImage, postImage, userId, flag);

      var a =
          await _firestore.collection("reportedContent").add(report.toJson());
      var docId = a.id;
      FirebaseFirestore.instance
          .collection('reportedContent')
          .doc(docId)
          .update({'Rid': docId});

      res = "succces";
    } catch (err) {
      res = err.toString();
      log(res);
    }
    return res;
  }
}
