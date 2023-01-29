import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:faydh/services/firestore_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_posts.dart';

class MyCard extends StatefulWidget {
  final snap;
  var id;
  DocumentReference<Map<String, dynamic>> reference;

  MyCard({
    required this.snap,
    required this.id,
    required this.reference,
    super.key,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  String myUsername = "";

  var _value;
  var seen = false;

  @override
  void initState() {
    myUsername = "";
    getUser2();
    // TODO: implement initState
  }

  Future getUser2() async {
    if (!seen) {
      var collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot =
          await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (docSnapshot != null && mounted) {
        Map<String, dynamic>? data = docSnapshot.data();
        _value = data?['username'];
        setState(() {
          myUsername = _value.toString();
        });
        //myUsername = _value.toString() ;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _dta = "${widget.snap["postImage"].toString()}";

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        /*  shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(8),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              )), */
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 62, 112, 82).withOpacity(0.9),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPost(
                                      newID: widget.id,
                                      title: "${widget.snap["postText"]}",
                                      imgUrl: "${widget.snap["postImage"]}",
                                      path: "${widget.snap["pathImage"]}",
                                      reference: widget.reference,
                                    )),
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(226, 29, 92, 76),
                        )),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                  title: const Text(
                                    'تأكيد الحذف',
                                    textAlign: TextAlign.right,
                                  ),
                                  content: const Text(
                                    "هل أنت متأكد من حذف المحتوى ؟ ",
                                    textAlign: TextAlign.right,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("إلغاء"),
                                      onPressed: () {
                                        // callback function for on click event of Cancel button
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("موافق"),
                                      onPressed: () async {
                                        widget.reference.delete();

                                        print(widget.id.toString());

                                        Navigator.pop(context);

                                        print("check");
                                      },
                                    ),
                                  ]);
                            });
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 172, 8, 8),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        //   ),
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
    var _dta = "${widget.snap["postImage"].toString()}";
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
              child: Text("${widget.snap["postText"].toString()}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          if (_dta.isNotEmpty)
            SizedBox(
              width: 250,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.grey,
                    child: Image(
                      image: NetworkImage(_dta),
                      fit: BoxFit.cover,
                      height: 150,
                      width: 250,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget tweetHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              myUsername,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        //  Spacer(),
      ],
    );
  }
}
