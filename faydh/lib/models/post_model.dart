import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String Cid;

  String postUserName = "";

  final String postText; //
  final String postImage; //
  final String pathImage; //
  final String userId;
  final DateTime postDate;

  Posts.allPostsConstructor({
    required this.Cid,
    required this.postUserName,
    required this.postText,
    required this.postImage, //
    required this.pathImage, //
    required this.userId,
    required this.postDate,
  });

  Posts.postConstructor(this.Cid,this.postText,this.postImage,this.pathImage,this.userId, this.postDate);

  Map<String, dynamic> toJson() => {
        "Cid": Cid,
        "postText": postText,
        "postImage": postImage,
        "pathImage": pathImage,
        "userId": userId,
        "postDate": postDate
      };

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Posts.allPostsConstructor(
        Cid: snapshot["Cid"],
        postUserName: snapshot["postUserName"],
        userId: snapshot["userId"],
        postText: snapshot["postText"],
        pathImage: snapshot["pathImage"],
        postImage: snapshot["postImage"],
        postDate: snapshot["postDate"]);
  }
}
