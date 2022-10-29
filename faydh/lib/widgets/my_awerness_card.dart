import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_posts.dart';

class MyCard extends StatelessWidget {
  final snap;
  var id;
  var delete;

  MyCard({
    required this.snap,
    required this.id,
    required this.delete,
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
                          print(snap);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPost(
                                      newID: id,
                                      title: "${snap["postTitle"]}",
                                      imgUrl: "${snap["postImage"]}",
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
                                    "حذف المحتوى ؟ ",
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
                                        delete.delete();

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
          Container(
            child: _dta != ""
                ? Image(
                    height: 150,
                    width: 250,
                    image: NetworkImage(
                      "${snap["postImage"].toString()}",
                    ))
                : SizedBox(
                    height: 0,
                    width: 0,
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
