//import 'dart:html';

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/ApproveBusiness.dart';
import 'package:faydh/models/reported_model.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faydh/components/background.dart';
import 'package:http/http.dart' as http;

class reportedContent extends StatefulWidget {
  final snap;
  final reported postData;
  //  var id;
  // DocumentReference<Map<String, dynamic>> reference;

  reportedContent(
      {this.snap,
      required this.postData,
      //   required this.id,
      //  required this.reference,
      super.key});

  @override
  State<reportedContent> createState() => _reportedContent();
}

@override
class _reportedContent extends State<reportedContent> {
  String id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
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
                  color:
                      const Color.fromARGB(255, 62, 112, 82).withOpacity(0.9),
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

  Widget tweetBody() {
    var _dta = "${widget.postData.pathImage.toString()}";
    var _dta2 = widget.postData.postImage.toString();

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
                  " اسم المستخدم" +
                      " : " +
                      widget.postData.postUserName.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 2, bottom: 2, left: 2),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 2, right: 0, bottom: 2, left: 50),
              child: Text(
                  //"${widget.snap["postText"].toString()}",
                  " البريد الإلكتروني" +
                      " : " +
                      widget.postData.postEmail.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
      
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 10, bottom: 2, left: 2),
                child: Padding(
                   padding: const EdgeInsets.only( top: 2, right: 0, bottom: 2, left: 50),

                     child: GestureDetector(
                      onTap:(){
                        
                         List<String> list = widget.postData.Reporters;
                         List<String> strings = List<String>.from(widget.postData.Reporters);
                         print(list);
                         var listString ="" ;
                         var num ;

                         log('data: $strings');

                         for(var i = 0 ; i<(widget.postData.reportCount) ; i++){
                   num = i+1;
               
                          listString += list[i] +"   -$num " ;
                         listString += "\n";


                         }
                             showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2,
                                                right: 10,
                                                bottom: 2,
                                                left: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: const [
                                                Text(  " :اسماء المستخدمين المبلغين \n"
                                                ,style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Positioned(
                                                    child: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xFFd6ecd0),
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 40,
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    right: 10,
                                                    bottom: 2,
                                                    left: 50),
                                                child: Align(
                                                
                                                  alignment: Alignment.centerRight,
                                                  child:
          
                                                   Column(
                                                     children: [
                                                   
                                                             Padding(
                                                               padding: const EdgeInsets.fromLTRB(100, 3, 10, 0),
                                                               child: Text(
                                                          textAlign: TextAlign.right,
                                                          //"${widget.snap["postText"].toString()}",
                                                          "  ${listString} \n" 
                                                            
                                                        , style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          )),
                                                             ),

                                                           
                                                     ],
                                                   ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            
                                            ],
                                          ));
                                    }
                                    );
                           
                      } , child: const Text('اسم المستخدم المبلغ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 102, 204),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)),
                     
                      
                                    ) ,
                                   
                                   
                )
                )
                ]

                     ),


                
              Padding(
                  padding:
                      const EdgeInsets.only(top: 8, right: 10, bottom: 2, left: 2),
                  child: widget.postData.flag != 2
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 2, right: 0, bottom: 2, left: 50),
                          child: GestureDetector(
                            onTap: () {
                              if (widget.postData.flag == 0) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2,
                                                right: 0,
                                                bottom: 2,
                                                left: 50),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: const [
                                                Text("تفاصيل المنشور"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Positioned(
                                                    child: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xFFd6ecd0),
                                                  radius: 40,
                                                  child: Icon(
                                                    Icons.file_copy_outlined,
                                                    size: 55,
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    right: 20,
                                                    bottom: 2,
                                                    left: 50),
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      textAlign: TextAlign.right,
                                                      //"${widget.snap["postText"].toString()}",
                                                      " المحتوى: " +
                                                          "${widget.postData.postText.toString()}",
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
                                                      borderRadius:
                                                          BorderRadius.circular(20),
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
                                              if (_dta.isEmpty)
                                                const SizedBox(
                                                  width: 0,
                                                  height: 0,
                                                ),
                                            ],
                                          ));
                                    }
                                    /*Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                MediaQuery.of(context).size.width /
                                                    10,
                                            vertical:
                                                MediaQuery.of(context).size.height /
                                                    3.3),
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 50),
                                              height: double.maxFinite,
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFf7f7f7),
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50,
                                                              right: 30,
                                                              bottom: 2,
                                                              left: 2),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 2,
                                                                right: 0,
                                                                bottom: 2,
                                                                left: 50),
                                                        child: Text(
                                                            //"${widget.snap["postText"].toString()}",
                                                            "${widget.postData.postText.toString()}",
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  if (_dta.isNotEmpty)
                                                    SizedBox(
                                                      width: 250,
                                                      child: Center(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20),
                                                          child: Container(
                                                            color: Colors.grey,
                                                            child: Image(
                                                              image: NetworkImage(
                                                                  _dta),
                                                              fit: BoxFit.cover,
                                                              height: 150,
                                                              width: 250,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (_dta.isEmpty)
                                                    SizedBox(
                                                      width: 0,
                                                      height: 0,
                                                    )
                                                ],
                                              ),
                                            ),
                                            const Positioned(
                                                right: 0,
                                                left: 0,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xFFd6ecd0),
                                                  radius: 40,
                                                  child: Icon(
                                                    Icons.file_copy_outlined,
                                                    size: 55,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      )*/
                                    );
                              } else if (widget.postData.flag == 1) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2,
                                                right: 0,
                                                bottom: 2,
                                                left: 50),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: const [
                                                Text("تفاصيل الإعلان"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Positioned(
                                                    child: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xFFd6ecd0),
                                                  radius: 40,
                                                  child: Icon(
                                                    Icons.file_copy_outlined,
                                                    size: 55,
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    right: 20,
                                                    bottom: 2,
                                                    left: 50),
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      textAlign: TextAlign.right,
                                                      //"${widget.snap["postText"].toString()}",
                                                      "  عنوان الطعام: " +
                                                          "${widget.postData.postTitle.toString()}",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    right: 20,
                                                    bottom: 2,
                                                    left: 5),
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      textAlign: TextAlign.right,

                                                      //"${widget.snap["postText"].toString()}",
                                                      "  وصف الطعام: " +
                                                          "${widget.postData.postText.toString()}",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              if (_dta2.isNotEmpty)
                                                SizedBox(
                                                  width: 250,
                                                  child: Center(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                      child: Container(
                                                        color: Colors.grey,
                                                        child: Image(
                                                          image:
                                                              NetworkImage(_dta2),
                                                          fit: BoxFit.cover,
                                                          height: 150,
                                                          width: 250,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if (_dta2.isEmpty)
                                                const SizedBox(
                                                  width: 0,
                                                  height: 0,
                                                ),
                                            ],
                                          ));
                                    }
                                
                                    );
                              }
                            },
                            child: const Text('التفاصيل',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 102, 204),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)),
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        )),
          
          
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  child: widget.postData.flag != 2
                      ? Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: 120,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  backgroundColor:
                                      const Color.fromARGB(255, 18, 57, 20),
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          title: const Text(
                                            "تأكيد ",
                                            textAlign: TextAlign.right,
                                          ),
                                          content: const Text(
                                            "هل أنت متأكد من أن المحتوى غير مخالف ؟ ",
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
                                                //     widget.reference.delete();
                                                print(widget.postData.Rid
                                                    .toString());
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'reportedContent')
                                                    .doc(widget.postData.Rid
                                                        .toString())
                                                    .delete();

                                                //   print(widget.id.toString());
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Text(
                                  'محتوى غير مخالف',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        )
                      : Padding(
                          //88
                          padding: const EdgeInsets.fromLTRB(75, 0, 25, 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: 120,
                                height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    backgroundColor:
                                        const Color.fromARGB(255, 18, 57, 20),
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            title: const Text(
                                              "تأكيد ",
                                              textAlign: TextAlign.right,
                                            ),
                                            content: const Text(
                                              "هل أنت متأكد من أن المستخدم غير مخالف ؟ ",
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
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'reportedContent')
                                                      .doc(widget.postData.Rid
                                                          .toString())
                                                      .delete();

                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(widget
                                                          .postData.userId
                                                          .toString())
                                                      .update({
                                                    'ReportCount':
                                                        FieldValue.increment(-1)
                                                  });

                                                  //   print(widget.id.toString());
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text(
                                    'مستخدم غير مخالف',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 9.8,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        )),
              Container(
                  child: widget.postData.flag != 2
                      ? Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: 120,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  backgroundColor:
                                      const Color.fromARGB(255, 194, 5, 5),
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          title: const Text(
                                            "تأكيد الحظر",
                                            textAlign: TextAlign.right,
                                          ),
                                          content: const Text(
                                            "هل أنت متأكد من حظر المستخدم ؟ ",
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
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(widget.postData.userId
                                                        .toString())
                                                    .update({'Active': false});

                                                FirebaseFirestore.instance
                                                    .collection('posts')
                                                    .where('userId',
                                                        isEqualTo: widget
                                                            .postData.userId)
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((doc) {
                                                    FirebaseFirestore.instance
                                                        .collection('posts')
                                                        .doc(doc["Cid"])
                                                        .delete();
                                                  });
                                                });

                                                /*  FirebaseFirestore.instance
                                                      .collection('foodPost')
                                                      .where('Cid',
                                                          isEqualTo: widget
                                                              .postData.userId)
                                                      .get()
                                                      .then((QuerySnapshot
                                                          querySnapshot) {
                                                    querySnapshot.docs
                                                        .forEach((doc) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'foodPost')
                                                          .doc(doc["docId"])
                                                          .delete();
                                                    });
                                                  });*/

                                                /*  FirebaseFirestore.instance
                                                      .collection(
                                                          'reportedContent')
                                                      .where('userId',
                                                          isEqualTo: widget
                                                              .postData.userId)
                                                      .get()
                                                      .then((QuerySnapshot
                                                          querySnapshot) {
                                                    querySnapshot.docs
                                                        .forEach((doc) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'reportedContent')
                                                          .doc(doc["Rid"])
                                                          .delete();
                                                    });
                                                  });*/

                                                FirebaseFirestore.instance
                                                    .collection('foodPost')
                                                    .doc(widget.postData.postId
                                                        .toString())
                                                    .update({
                                                  'providerblocked': true
                                                });

                                                var snapp =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('foodPost')
                                                        .doc(widget
                                                            .postData.postId)
                                                        .get();
                                                print('not enter');
                                                if (snapp.exists) {
                                                  print(' enter');
                                                  Map<String, dynamic>? data =
                                                      snapp.data();

                                                  var reservedby =
                                                      data!["reservedby"];

                                                  if (reservedby == null) {
                                                    print('trueee');
                                                    FirebaseFirestore.instance
                                                        .collection('foodPost')
                                                        .doc(widget
                                                            .postData.postId)
                                                        .delete();
                                                  } else {
                                                    print('no');
                                                  }
                                                }

                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'reportedContent')
                                                    .doc(widget.postData.Rid
                                                        .toString())
                                                    .delete();

                                                sendEmail(
                                                  name: widget
                                                      .postData.postUserName
                                                      .toString(),
                                                  email: widget
                                                      .postData.postEmail
                                                      .toString(),
                                                );

                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Text(
                                  ' حظر المستخدم  ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        )
                      : Padding(
                          //was 50
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                                width: 120,
                                height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    backgroundColor:
                                        const Color.fromARGB(255, 194, 5, 5),
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            title: const Text(
                                              "تأكيد الحظر",
                                              textAlign: TextAlign.right,
                                            ),
                                            content: const Text(
                                              "هل أنت متأكد من حظر المستخدم ؟ ",
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
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(widget
                                                          .postData.userId
                                                          .toString())
                                                      .update(
                                                          {'Active': false});

                                                  FirebaseFirestore.instance
                                                      .collection('posts')
                                                      .where('userId',
                                                          isEqualTo: widget
                                                              .postData.userId)
                                                      .get()
                                                      .then((QuerySnapshot
                                                          querySnapshot) {
                                                    querySnapshot.docs
                                                        .forEach((doc) {
                                                      FirebaseFirestore.instance
                                                          .collection('posts')
                                                          .doc(doc["Cid"])
                                                          .delete();
                                                    });
                                                  });

                                                  FirebaseFirestore.instance
                                                      .collection('foodPost')
                                                      .doc(widget
                                                          .postData.postId
                                                          .toString())
                                                      .update({
                                                    'providerblocked': true
                                                  });

                                                  var snapp =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'foodPost')
                                                          .doc(widget
                                                              .postData.postId)
                                                          .get();

                                                  if (snapp.exists) {
                                                    Map<String, dynamic>? data =
                                                        snapp.data();

                                                    var reservedby =
                                                        data!["reservedby"];

                                                    if (reservedby == null) {
                                                      print('trueee');
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'foodPost')
                                                          .doc(widget
                                                              .postData.postId)
                                                          .delete();
                                                    } else {
                                                      print('no');
                                                    }
                                                  }

                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'reportedContent')
                                                      .doc(widget.postData.Rid
                                                          .toString())
                                                      .delete();

                                                  sendEmail(
                                                    name: widget
                                                        .postData.postUserName
                                                        .toString(),
                                                    email: widget
                                                        .postData.postEmail
                                                        .toString(),
                                                  );
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text(
                                    ' حظر المستخدم  ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        )),
              Container(
                child: widget.postData.flag != 2
                    ? Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 120,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                backgroundColor:
                                    const Color.fromARGB(255, 194, 5, 5),
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),
                                        title: const Text(
                                          "تأكيد حذف المحتوى من الجميع",
                                          textAlign: TextAlign.right,
                                        ),
                                        content: const Text(
                                          "هل أنت متأكد من حذف المحتوى من الجميع  ؟ ",
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
                                              if (widget.postData.flag == 0) {
                                                FirebaseFirestore.instance
                                                    .collection('posts')
                                                    .doc(widget.postData.postId
                                                        .toString())
                                                    .delete();
                                              } else if (widget.postData.flag ==
                                                  1) {
                                                FirebaseFirestore.instance
                                                    .collection('foodPost')
                                                    .doc(widget.postData.postId
                                                        .toString())
                                                    .update({
                                                  'providerblocked': true
                                                });

                                                var snapp =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('foodPost')
                                                        .doc(widget
                                                            .postData.postId)
                                                        .get();
                                                print('not enter');
                                                if (snapp.exists) {
                                                  print(' enter');
                                                  Map<String, dynamic>? data =
                                                      snapp.data();

                                                  var reservedby =
                                                      data!["reservedby"];

                                                  if (reservedby == null) {
                                                    print('trueee');
                                                    FirebaseFirestore.instance
                                                        .collection('foodPost')
                                                        .doc(widget
                                                            .postData.postId)
                                                        .delete();
                                                  } else {
                                                    print('no');
                                                  }
                                                }
                                              }

                                              FirebaseFirestore.instance
                                                  .collection('reportedContent')
                                                  .doc(widget.postData.Rid
                                                      .toString())
                                                  .delete();

                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: const Text(
                                'حذف المحتوى ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        
     ] ) 
       );
    
  }

  Widget tweetHeader() {
    //  var cardId = widget.postData.userId.toString();
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
                  widget.postData.ReportReason.toString(),

                  //  "me",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 249, 9, 9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future sendEmail({
  required String name,
  required String email,
}) async {
  const serviceId = 'service_xutbn8n';
  var userId = '7hJUinnZHv07_0-Ae';

  var templateId = 'template_4i58c5d';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  var response = await http.post(
    url,
    headers: {
      'origin': 'http:localhost',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'service_id': serviceId,
      'user_id': userId,
      'template_id': templateId,
      'template_params': {
        'to_name': name,
        'sender_email': email,
      }
    }),
  );

  print(response.body);
}
