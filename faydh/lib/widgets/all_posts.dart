import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_posts.dart';

class AllPostsCard extends StatelessWidget {
  final snap;

  AllPostsCard({
    required this.snap,
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