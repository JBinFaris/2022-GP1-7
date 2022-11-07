import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AllPostsCard extends StatefulWidget {
  final snap;

  AllPostsCard({
    required this.snap,
    super.key,
  });

  @override
  State<AllPostsCard> createState() => _AllPostsCardState();
}
class _AllPostsCardState extends State<AllPostsCard> {


String myUsername = "";



var seen = false ; 

  @override
  void initState() {
     myUsername = ""; 
    getUser2();
    // TODO: implement initState
  }
Future getUser2() async{
 
  if(!seen){
    var collection = FirebaseFirestore.instance.collection('users');
var docSnapshot = await collection.doc("${widget.snap["userId"].toString()}" ).get();
if (docSnapshot!= null && mounted ) {
  Map<String, dynamic>? data = docSnapshot.data();
  var _value = data?['username'];
   setState((){
    myUsername = ""; 
    myUsername = _value.toString() ;
   });
 //myUsername = _value.toString() ;
 }}
}

  @override
  Widget build(BuildContext context) {
    var _dta = "${widget.snap["postImage"].toString()}";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(8),
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
              padding: const EdgeInsets.only(
                  top: 20, right: 0, bottom: 2, left: 50),
              child: Text("${widget.snap["postText"].toString()}",
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
