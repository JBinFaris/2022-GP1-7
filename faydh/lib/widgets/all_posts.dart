import 'dart:ui';
import 'package:faydh/reports.dart';
import 'package:faydh/services/firestore_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/post_model.dart';

class AllPostsCard extends StatefulWidget {
  final snap;
  final Posts postData;

  AllPostsCard({
    this.snap,
    required this.postData,
    super.key,
  });

  @override
  State<AllPostsCard> createState() => _AllPostsCardState();
}

class _AllPostsCardState extends State<AllPostsCard> {
  String myUsername = "";

  var seen = false;

  @override
  void initState() {
    myUsername = "";
    //getUser2();
    // TODO: implement initState
  }

  Future getUser2() async {
    if (!seen) {
      var collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot =
          await collection.doc("${widget.snap["userId"].toString()}").get();
      if (docSnapshot != null && mounted) {
        Map<String, dynamic>? data = docSnapshot.data();
        var _value = data?['username'];
        setState(() {
          myUsername = "";
          myUsername = _value.toString();
        });
        //myUsername = _value.toString() ;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //var _dta = "${widget.snap["postImage"].toString()}";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 0,
        color: Colors.transparent,

        //  color: Colors.white.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 62, 112, 82).withOpacity(0.9),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tweetAvatar(),
                    tweetBody(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.account_circle_rounded,
          color: Color.fromARGB(226, 29, 92, 76),
          size: 40,
        ),
      ),
    );
  }

  Widget tweetBody() {
    //var _dta = "${widget.snap["postImage"].toString()}";
    var _dta = widget.postData.postImage.toString();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 2, bottom: 2, left: 2),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20, right: 0, bottom: 2, left: 50),
              child: Text(
                  //"${widget.snap["postText"].toString()}",
                  widget.postData.postText.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_dta.isNotEmpty)
            SizedBox(
              width: 250,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    //  color: Colors.grey,
                    child: Image(
                      image: NetworkImage(_dta),
                      fit: BoxFit.contain,
                      // height: 150,
                      //  width: 250,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget tweetHeader() {
    var cardId = widget.postData.userId.toString();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.postData.postUserName.toString(),

                  //  "me",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (cardId != FirebaseAuth.instance.currentUser!.uid)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
                              onTap: (() {}),
                              child: PopupMenuButton(
                                  itemBuilder: (ctx) => [
                                        PopupMenuItem(
                                          child: const Text(
                                              'تبليغ محتوى غير لائق',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          onTap: () {
                                            Future.delayed(
                                              const Duration(seconds: 0),
                                              () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                        title: const Text(
                                                          'تأكيد البلاغ',
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                        content: const Text(
                                                          "هل أنت متأكد من التبليغ عن هذا المحتوى ؟ ",
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                        actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                            const Text("إلغاء"),
                                                        onPressed: () {
                                                          // callback function for on click event of Cancel button
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child:
                                                            const Text("موافق"),
                                                        onPressed: () async {
                                                          var snapss2 = await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'reportedContent')
                                                              .where('userId',
                                                                  isEqualTo: widget
                                                                      .postData
                                                                      .userId
                                                                      .toString())
                                                              .where('flag',
                                                                  isEqualTo: 0)
                                                              .where('postId',
                                                                  isEqualTo: widget
                                                                      .postData
                                                                      .Cid
                                                                      .toString())
                                                              .get();

                                                          var userinfosnap =
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      ?.uid)
                                                                  .get();

                                                          Map<String, dynamic>?
                                                              uinfo =
                                                              userinfosnap
                                                                  .data();

                                                          String username =
                                                              uinfo![
                                                                  "username"];

                                                          var user = username;

                                                          if (snapss2.size ==
                                                              0) {
                                                            FirestoreMethods()
                                                                .uploadReport(
                                                              //postUserName: myUsername,
                                                              ReportReason:
                                                                  "محتوى غير لائق (المنتدى)",
                                                              postId: widget
                                                                  .postData.Cid
                                                                  .toString(),
                                                              postText: widget
                                                                  .postData
                                                                  .postText
                                                                  .toString(),
                                                              pathImage: widget
                                                                  .postData
                                                                  .pathImage
                                                                  .toString(),
                                                              postImage: widget
                                                                  .postData
                                                                  .postImage
                                                                  .toString(),
                                                              userId: widget
                                                                  .postData
                                                                  .userId
                                                                  .toString(),
                                                              flag: 0,
                                                              reportCount: 1,
                                                              Reporters: [user],
                                                            );
                                                          } else {
                                                            var alldocs =
                                                                snapss2.docs;
                                                            for (var i = 0;
                                                                i <
                                                                    snapss2
                                                                        .size;
                                                                i++) {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'reportedContent')
                                                                  .doc(alldocs[
                                                                      i]["Rid"])
                                                                  .update({
                                                                "Reporters":
                                                                    FieldValue
                                                                        .arrayUnion([
                                                                  user
                                                                ])
                                                              });
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'reportedContent')
                                                                  .doc(alldocs[
                                                                      i]["Rid"])
                                                                  .update({
                                                                "reportCount":
                                                                    FieldValue
                                                                        .increment(
                                                                            1)
                                                              });
                                                            }
                                                          }
                                                          Navigator.pop(
                                                              context);

                                                          print("check");
                                                        },
                                                      ),
                                                    ]),
                                              ),
                                            );
                                          },
                                        )
                                      ])),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),

        //  Spacer(),
      ],
    );
  }
}
