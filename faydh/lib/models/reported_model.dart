import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/models/user_model.dart';

class reported {
  final String Rid;
  final String ReportReason;
  final String? postId;
  final String? postText; //
  final String? postImage; //
  final String? pathImage; //
  final String userId;
  final int? flag;
  final List<String> Reporters ;
  final int reportCount ;

  String? postUserName = "";
  String? postEmail = "";

  String? postTitle;

  //final DateTime postDate;

  reported.allReportedConstructor({
    required this.Rid,
    required this.ReportReason,
    this.postId,
    this.postText,
    this.postImage, //
    this.pathImage, //
    this.postTitle,
    required this.Reporters,
    required this.reportCount,
    required this.userId,
    required this.flag,
    this.postUserName,
    this.postEmail,
    //required this.postDate,
  });

  reported.ReportedConstructor(this.Rid, this.ReportReason, this.postId,this.Reporters,
      this.reportCount, this.postText, this.postImage, this.pathImage, this.userId, this.flag);

  Map<String, dynamic> toJson() => {
        "Rid": Rid,
        "ReportReason": ReportReason,
        "userId": userId,
        "flag": flag,
        "Reporters": Reporters ,
        "reportCount": reportCount,
        if (flag != 2) "postId": postId,
        if (flag == 1) "postTitle": postTitle,
        if (flag != 2 && postText != "") "postText": postText,
        if (flag != 2 && postImage != "") "postImage": postImage,
        if (flag != 2 && pathImage != "") "pathImage": pathImage,

        // "postDate": postDate
      };

  static reported fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return reported.allReportedConstructor(
        Rid: snapshot["Rid"],
        ReportReason: snapshot["ReportReason"],
        postId: snapshot["postId"],
        Reporters: snapshot["Reporters"],
        userId: snapshot["userId"],
        postText: snapshot["postText"],
        pathImage: snapshot["pathImage"],
        postImage: snapshot["postImage"],
        flag: snapshot["flag"],
        reportCount: snapshot["reportCount"],
        // postDate: snapshot["postDate"]
        );
  }
}
