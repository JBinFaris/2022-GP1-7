import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/models/post_model.dart';
import 'package:faydh/services/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Uplaod the post::
  Future<String> uploadPost({
    required postUserName,
    required String postTitle,
    Uint8List? file, //
  }) async {
    String res = "حصل خطأ";

    try {
      String image = '';
      if (file != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage("postsImage", file, true);
        if (photoUrl.isEmpty) {
          image = '';
        } else {
          image = photoUrl;
        }
      }
      String userId = _auth.currentUser!.uid;

      Posts posts = Posts(
          postTitle: postTitle,
          postImage: image,
          userId: userId,
          postUserName: postUserName);

      _firestore.collection("posts").add(posts.toJson());

      res = "تم بنجاح";
    } catch (err) {
      res = err.toString();
      print(res);
    }
    return res;
  }
  

  Future<String> updatePostTwo({

    required String title,
    required String id,
  }) async {
    String res = "حصل خطأ";
    print(res);
    print("men....$id");
    try {
      // var photoUrl =
      //     await StorageMethods().uploadImageToStorage("postImages", file, true);

      Map<String, String> values = {"postTitle": title };
      await _firestore
          .collection('posts')
          .doc(id)
          .update(values)
          .then((value) {
        res = "تم بنجاح";
      });
    } catch (e) {
      print(e.toString());
    }
    return res;
  }
}