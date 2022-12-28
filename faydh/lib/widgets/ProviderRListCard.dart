import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String id = FirebaseAuth.instance.currentUser!.uid;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

@override
void initState() {
  String id = FirebaseAuth.instance.currentUser!.uid;

  //getUser2();
  // TODO: implement initState
}

String? usrEmail;
String? usrName;
String? phoneNo;
String? consId;

//Future<String?> getData(String id) async{

// var a = await FirebaseFirestore.instance
//   .collection('users')
//   .doc(id)
//   .get();

//    usrEmail = a['email'];
//    usrName = a['username'];
//    phoneNo = a['phoneNumber'];
//}

class ProviderRlistCard extends StatefulWidget {
  final snap;
  const ProviderRlistCard({this.snap, super.key});

  @override
  State<ProviderRlistCard> createState() => _ProviderRlistCardState();
}

class _ProviderRlistCardState extends State<ProviderRlistCard> {
  String myUsername = "";
  var seen = false;

  @override
  Widget build(BuildContext context) {
    consId = ("${widget.snap["reservedby"].toString()}");
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //print(proId);
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(consId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          //  return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          phoneNo = (" ${data['phoneNumber']}");
          usrEmail = (" ${data['email']}");
          usrName = (" ${data['username']}");
        }
        print(usrEmail);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0,
                color: Colors.white,
              ),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(125, 158, 158, 158),
                                spreadRadius: 0.01,
                                blurRadius: 15)
                          ]),
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "تأكيد الإستلام",
                                          textAlign: TextAlign.right,
                                        ),
                                        content: const Text(
                                          (" هل تم إستلام الطعام من قبل الحاجز ؟ "),
                                          textAlign: TextAlign.right,
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("لا"),
                                            onPressed: () {
                                              // callback function for on click event of Cancel button
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("نعم"),
                                            onPressed: () async {
                                              _firestore
                                                  .collection("foodPost")
                                                  .doc(
                                                      "${widget.snap["docId"].toString()}")
                                                  .delete();

                                              Navigator.pop(context);

                                              print("check");
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  Text("قبول"),
                                ],
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(125, 158, 158, 158),
                                spreadRadius: 0.3,
                                blurRadius: 15)
                          ]),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "تأكيد الغاء الحجز",
                                        textAlign: TextAlign.right,
                                      ),
                                      content: Text(
                                        (" هل أنت متأكد من الغاء الحجز ؟ "),
                                        textAlign: TextAlign.right,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text("لا"),
                                          onPressed: () {
                                            // callback function for on click event of Cancel button
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("نعم"),
                                          onPressed: () async {
                                            _firestore
                                                .collection("foodPost")
                                                .doc(widget.snap["docId"]
                                                    .toString())
                                                .update({"reserve": "0"});

                                            Navigator.pop(context);

                                            print("check");
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.disabled_by_default,
                                      color: Colors.red,
                                    ),
                                    Text("الغاء الحجز"),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
    return Expanded(
      child: Column(
        children: [
          tweetHeader(),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 0, bottom: 2, left: 2),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15, right: 0, bottom: 2, left: 50),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text((" رقم الحاجز : ${phoneNo!}"),
                        // " رقم للحاجز ",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text((" البريد الإلكتروني للحاجز : ${usrEmail!}"),
                          //   " البريد الإلكتروني للحاجز ",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" نوع الطعام: " + widget.snap["postTitle"].toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" موقع الإستلام: " + widget.snap["postAdress"].toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" كمية الطعام: " + widget.snap["food_cont"].toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.network(
                        widget.snap['postImage'],
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "تاريخ الانتهاء : ${widget.snap['postExp'].toString()}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 144, 177, 135),
                          fontSize: 12,
                        ),
                      )),
                ],
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
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Text(
                  //"me",
                  usrName!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
