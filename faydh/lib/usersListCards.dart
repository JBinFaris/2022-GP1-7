import 'package:faydh/AdminMain.dart';
import 'package:faydh/BlockedUserList.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/ApproveBusiness.dart';
import 'package:faydh/models/reported_model.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faydh/components/background.dart';
import 'package:http/http.dart' as http;

class UsersListCards extends StatefulWidget {
  final snap;

  const UsersListCards({this.snap, super.key});

  @override
  State<UsersListCards> createState() => _UsersListCardsState();
}

class _UsersListCardsState extends State<UsersListCards> {
  TextEditingController _searchTextController = new TextEditingController();
  String filter = "";

  @override
  initState() {
    super.initState();
    _searchTextController.addListener(() {
      print(_searchTextController.text);
      filter = _searchTextController.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('Active', isEqualTo: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    // print("cehecl");

    // print("collection lenG: ${foodPostStream.length}");
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1A4D2E),
        //title: const Text("  المستخدمين"),
        actions: <Widget>[
          // const Text(" قائمة المستخدمين    "),

          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 50, 5),
            child: SizedBox(
                width: 120,
                height: 120,
                child: FittedBox(
                  child: FloatingActionButton.extended(
                    heroTag: "btn1",
                    label: const Text(
                      "قائمة المحظورين ",
                      style: TextStyle(
                        color: Color(0xFF1A4D2E),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      size: 45.0,
                      color: Color(0xFF1A4D2E),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const BlockedUserList();
                        }),
                      );
                    },
                  ),
                )),
          ),
          //  const Padding(
          //  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),

          const Padding(
            padding: EdgeInsets.fromLTRB(0, 23, 27, 5),
            child: Flexible(
              child: Text(
                "قائمة المستخدمين ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //  ),
          Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return const AdminMain();
                    }),
                  );
                },
                backgroundColor: const Color(0xFF1A4D2E),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromARGB(225, 255, 255, 255),
                ),
              )),
        ],
      ),
      backgroundColor: Colors.green[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('حدث خطأ ما');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading..."));
          }
          if (snapshot.hasData && snapshot.data?.size == 0) {
            return const Center(
                child: Text("! لا يوجد مستخدمين",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )));
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                searchBar(),
                showItemsList(snapshot),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4),
      child: Transform.translate(
        offset: const Offset(0, -2),
        child: Container(
          height: 40.0,
          padding: const EdgeInsets.only(left: 20, top: 2, right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 20.0,
                offset: Offset(0, 6.0),
              ),
            ],
          ),
          child: TextField(
            controller: _searchTextController,
            textAlign: TextAlign.start,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
                size: 20.0,
              ),
              border: InputBorder.none,
              hintText: 'ابحث عن مستخدم ....',
            ),
          ),
        ),
      ),
    );
  }

  Widget showItemsList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return Expanded(
      child: ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

          return filter == null || filter == ''
              ? ItemDetails(data)
              : data['username']
                      .toString()
                      .toLowerCase()
                      .contains(filter.toLowerCase())
                  ? ItemDetails(data)
                  : Container();
        }).toList(),
      ),
    );
  }

  Widget ItemDetails(Map<String, dynamic> data) {
    // print(data);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
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
              tweetAvatar(),
              tweetBody(
                "${data['username'].toString()}",
                "${data['email'].toString()}",
                "${data['role'].toString()}",
                "${data['phoneNumber'].toString()}",
                "${data['uid'].toString()}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tweetAvatar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(280, 1, 40, 0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(3, 0, 5, 1),
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            color: const Color(0xFF1A4D2E),
            size: 80,
          ),
        ),
      ),
    );
  }

  Widget tweetBody(
      String username, String email, String role, String num, String useridd) {
    //var _dta = "${widget.snap["postImage"].toString()}";
    // print(username);

    return Column(
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //    tweetHeader(),

        Container(
          margin: const EdgeInsets.fromLTRB(50, 0, 60, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 5, 0),
                child: Text(
                    //"${widget.snap["postText"].toString()}",
                    ("  اسم المستخدم : " + username),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 5, 0),
                child: Text(
                    //"${widget.snap["postText"].toString()}",
                    ("  البريد  : " + email),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 3, 0, 0),
                child: Text(
                    //"${widget.snap["postText"].toString()}",
                    ("  نوع المستخدم : " + role),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 35, 0),
                child: Text(
                    //"${widget.snap["postText"].toString()}",
                    ("  رقم المستخدم : " + num),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.fromLTRB(40, 3, 70, 5),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 120,
                          height: 40,
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
                                            // print(useridd.toString());
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(useridd.toString())
                                                .update({'Active': false});
                                            FirebaseFirestore.instance
                                                .collection('posts')
                                                .where('userId',
                                                    isEqualTo:
                                                        useridd.toString())
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              querySnapshot.docs.forEach((doc) {
                                                FirebaseFirestore.instance
                                                    .collection('posts')
                                                    .doc(doc["Cid"])
                                                    .delete();
                                              });
                                            });
                                            FirebaseFirestore.instance
                                                .collection('foodPost')
                                                .where('Cid',
                                                    isEqualTo:
                                                        useridd.toString())
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              querySnapshot.docs.forEach((doc) {
                                                FirebaseFirestore.instance
                                                    .collection('foodPost')
                                                    .doc(doc["docId"])
                                                    .delete();
                                              });
                                            });

                                            FirebaseFirestore.instance
                                                .collection('reportedContent')
                                                .where('userId',
                                                    isEqualTo:
                                                        useridd.toString())
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              querySnapshot.docs.forEach((doc) {
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'reportedContent')
                                                    .doc(doc["Rid"])
                                                    .delete();
                                              });
                                            });
                                            sendEmail(
                                              name: email.toString(),
                                              email: username.toString(),
                                            );
                                            Navigator.of(context).pop();
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 10,
        ),
      ],
    );
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
}
