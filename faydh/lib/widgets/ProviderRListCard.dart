import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
String? usrNamee;
String? phonee;
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
//  final UserData ConsData;
  const ProviderRlistCard({
    this.snap,
    super.key,
    // required this.ConsData,
  });

  @override
  State<ProviderRlistCard> createState() => _ProviderRlistCardState();
}

class _ProviderRlistCardState extends State<ProviderRlistCard> {
  String myUsername = "";
  var seen = false;

  @override
  Widget build(BuildContext context) {
    //consId = ("${widget.snap["reservedby"].toString()}");
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    // _getUserData();
    //print(proId);

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc("${widget.snap["reservedby"]}").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        try {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            //  return Text("Full Name: ${data['full_name']} ${data['last_name']}");
            phonee = (" ${data['phoneNumber']}");
            usrEmail = (" ${data['email']}");
            usrNamee = (" ${data['username']}");
          }
        } catch (e) {
          print(e.toString());
        }
        ;

        print(usrEmail);
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
            /*  shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0,
            color: Colors.white,
          ),
        ),*/
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
                                          "?????????? ????????????????",
                                          textAlign: TextAlign.right,
                                        ),
                                        content: const Text(
                                          (" ???? ???? ???????????? ???????????? ???? ?????? ???????????? ?? "),
                                          textAlign: TextAlign.right,
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("????"),
                                            onPressed: () {
                                              // callback function for on click event of Cancel button
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("??????"),
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
                                children: const [
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  Text("?????????? ????????????????"),
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
                                        "?????????? ?????????? ??????????",
                                        textAlign: TextAlign.right,
                                      ),
                                      content: Text(
                                        (" ???? ?????? ?????????? ???? ?????????? ?????????? ?? "),
                                        textAlign: TextAlign.right,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text("????"),
                                          onPressed: () {
                                            // callback function for on click event of Cancel button
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("??????"),
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
                                    Text("?????????? ??????????"),
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
          tweetHeader(" ${phonee!}", " ${usrNamee!}"),
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
                    child: Text((" ?????? ???????????? : ${phonee}"),
                        // " ?????? ???????????? ",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  /*    Align(
                      alignment: Alignment.centerRight,
                      child: Text((" ???????????? ???????????????????? ???????????? : ${usrEmail}"),
                          //   " ???????????? ???????????????????? ???????????? ",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),*/
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" ?????? ????????????: " + widget.snap["postTitle"].toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" ???????? ????????????????: " + widget.snap["postAdress"].toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" ???????? ????????????: " + widget.snap["food_cont"].toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          widget.snap['postImage'],
                          height: 250,
                          width: 170,
                          //   fit: BoxFit.contain,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "?????????? ???????????????? : ${widget.snap['postExp'].toString()}",
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

  Widget tweetHeader(String pp, String nn) {
    //final Uri whatsapp = Uri.parse("https://wa.me/${phone!}");
    //final Uri call = Uri.parse("tel://${phone!}");

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
                  nn,
                  //  "me",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          onTap: (() {
                            // ignore: deprecated_member_use
                            launch('https://wa.me/' + pp);
                          }),
                          child: const Icon(
                            Icons.whatsapp,
                            size: 25,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // ignore: deprecated_member_use
                          launch("tel://" + pp);
                          print(phonee);
                        },
                        child: const Icon(
                          Icons.call,
                          size: 25,
                          color: Colors.green,
                        ),
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
