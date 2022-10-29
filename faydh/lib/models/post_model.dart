import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String postTitle; //

  final String postImage; //
  final String userId;
  final String postUserName;

  Posts({
    required this.postUserName,
    required this.postTitle,
    required this.postImage, //
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        "postTitle": postTitle,
        "postImage": postImage,
    "postUserName": postUserName,
        "userId": userId,
      };

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Posts(
      userId: snapshot["userId"],
      postUserName: snapshot["postUserName"],
      postTitle: snapshot["postTitle"],
      postImage: snapshot["postImage"],
    );
  }
}
