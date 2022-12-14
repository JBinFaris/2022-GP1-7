import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/models/post_model.dart';
import 'package:faydh/services/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DocumentReference ref =
      FirebaseFirestore.instance.collection("posts").doc();

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

      Posts posts = Posts.postConstructor(
          ref.id,
          postText,
          photoUrl['downloadUrl'] ?? '',
          photoUrl['path'] ?? '',
          userId,
          postDate);

      _firestore.collection("posts").add(posts.toJson());

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
}
