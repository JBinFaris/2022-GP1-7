import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String postTitle; //

  final String postImage; //
  final String pathImage; //
  final String userId;

  Posts({
    required this.postTitle,
    required this.postImage, //
    required this.pathImage, //
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        "postTitle": postTitle,
        "postImage": postImage,
        "pathImage": pathImage,
        "userId": userId,
      };

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Posts(
      userId: snapshot["userId"],
      postTitle: snapshot["postTitle"],
      pathImage: snapshot["pathImage"],
      postImage: snapshot["postImage"],
    );
  }
}
