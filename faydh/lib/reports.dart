import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/BlockedUserList.dart';
import 'package:faydh/models/post_model.dart';
import 'package:faydh/models/user_data_model.dart';
import 'package:faydh/reportedContent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faydh/widgets/ConsumerListCard.dart';
import 'models/reported_model.dart';

class reportsScreen extends StatefulWidget {
  const reportsScreen({Key? key}) : super(key: key);

  @override
  State<reportsScreen> createState() => _reportsScreenState();
}

String id = FirebaseAuth.instance.currentUser!.uid;

var dataoaded;
List<UserData> usersList = [];
List<reported> postList = [];

class _reportsScreenState extends State<reportsScreen> {
  @override
  void initState() {
    dataoaded = false;
  }

  Future getAllUsers() async {
    var collection = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await collection.get();

    List<dynamic> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in allData) {
      usersList.add(UserData(
          email: element['email'] ?? '',
          role: element['role'] ?? '',
          uid: element['uid'] ?? '',
          phoneNumber: element['phoneNumber'] ?? '',
          username: element['username'] ?? ''));
    }
    setState(() {
      dataoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!dataoaded) getAllUsers();

    return Scaffold(
        backgroundColor: const Color(0xffd6ecd0),
        appBar: AppBar(
            elevation: 2.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF1A4D2E),
            title: const Text(" البلاغات  "),
            /*  actions: <Widget>[
                SizedBox(
                    width: 160,
                    height: 130,
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
                    ))
              ],*/
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Color.fromARGB(225, 255, 255, 255),
              ),
            )),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [
                    0.1,
                    0.9
                  ],
                  colors: [
                    Color.fromARGB(142, 47, 101, 69),
                    Color(0xffd6ecd0)
                  ]),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('reportedContent')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snaphot) {
                  if (snaphot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }
                  if (snaphot.hasData && snaphot.data?.size == 0) {
                    return const Center(
                        child: Text(" لا توجد بلاغات",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )));
                  }
                  if (!dataoaded) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  } else {
                    QuerySnapshot<Object?>? querySnapshot = snaphot.data;

                    List<dynamic>? allData =
                        querySnapshot?.docs?.map((doc) => doc.data()).toList();
                    _clearAll();
                    for (var element in allData!) {
                      postList.add(reported.allReportedConstructor(
                        Rid: element['Rid'],
                        ReportReason: element['ReportReason'],
                        userId: element['userId'],
                        flag: element['flag'],
                        postId: element['postId'] ?? '',
                        postTitle: element['postTitle'] ?? '',
                        postText: element['postText'] ?? '',
                        postImage: element['postImage'] ?? '',
                        pathImage: element['pathImage'] ?? '',
                      ));
                    }
                    print(postList.length);

                    for (var i = 0; i < usersList.length; i++) {
                      for (var j = 0; j < postList.length; j++) {
                        if (usersList[i].uid == postList[j].userId) {
                          postList[j].postUserName = usersList[i].username;
                          postList[j].postEmail = usersList[i].email;
                        }
                      }
                    }
                    print(postList.length);

                    return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) => reportedContent(
                        postData: postList[index],
                        //  id: snaphot.data?.docs[index].id,
                        // reference: snaphot.data!.docs[index].reference,
                      ),
                    );
                  }
                }),
          ),
        ));
  }

  void _clearAll() {
    postList.clear();
  }
}
