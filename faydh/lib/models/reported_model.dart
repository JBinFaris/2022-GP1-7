import 'package:cloud_firestore/cloud_firestore.dart';

class reported {
  final String Rid;
  final String postId;
  String postUserName = "";

  final String postText; //
  final String postImage; //
  final String pathImage; //
  final String userId;

  //final DateTime postDate;

  reported.allReportedConstructor({
    required this.Rid,
    required this.postId,
    required this.postUserName,
    required this.postText,
    required this.postImage, //
    required this.pathImage, //
    required this.userId,
    //required this.postDate,
  });

  reported.ReportedConstructor(this.Rid, this.postId, this.postText,
      this.postImage, this.pathImage, this.userId);

  Map<String, dynamic> toJson() => {
        "Rid": Rid,
        "postId": postId,
        "postText": postText,
        "postImage": postImage,
        "pathImage": pathImage,
        "userId": userId,
        // "postDate": postDate
      };

  static reported fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return reported.allReportedConstructor(
      Rid: snapshot["Rid"],
      postId: snapshot["postId"],
      postUserName: snapshot["postUserName"],
      userId: snapshot["userId"],
      postText: snapshot["postText"],
      pathImage: snapshot["pathImage"],
      postImage: snapshot["postImage"],
      // postDate: snapshot["postDate"]
    );
  }
}
