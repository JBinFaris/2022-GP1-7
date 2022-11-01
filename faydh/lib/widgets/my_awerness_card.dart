import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_posts.dart';

class MyCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    var _dta = "${snap["postImage"].toString()}";

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(
                Radius.circular(30.0),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                                      newID: id,
                                      title: "${snap["postTitle"]}",
                                      imgUrl: "${snap["postImage"]}",
                                      path: "${snap["pathImage"]}",
                                      reference: reference,
                                    )),
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          color: Color.fromARGB(226, 29, 92, 76),
                        )),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text(
                                    'تأكيد الحذف',
                                    textAlign: TextAlign.right,
                                  ),
                                  content: Text(
                                    "هل أنت متأكد من حذف المحتوى ؟ ",
                                    textAlign: TextAlign.right,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("إلغاء"),
                                      onPressed: () {
                                        // callback function for on click event of Cancel button
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("موافق"),
                                      onPressed: () async {
                                        reference.delete();

                                        print(id.toString());

                                        Navigator.pop(context);

                                        print("check");
                                      },
                                    ),
                                  ]);
                            });
                      },
                      child: Icon(
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
      ),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
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
    var _dta = "${snap["postImage"].toString()}";
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 2, bottom: 2, left: 2),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 0, bottom: 2, left: 50),
                child: Text("${snap["postTitle"].toString()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
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
              "${snap["postUserName"].toString()}",
              style: TextStyle(
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
