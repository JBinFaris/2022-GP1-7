import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/Database/database.dart';
import 'package:faydh/widgets/ProviderRListCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:faydh/services/firestore_methods.dart';

import 'models/user_data_model.dart';

class ReservedProviderScreen extends StatefulWidget {
  const ReservedProviderScreen({Key? key}) : super(key: key);

  @override
  State<ReservedProviderScreen> createState() => _ReservedProviderScreenState();
}

String id = FirebaseAuth.instance.currentUser!.uid;

class _ReservedProviderScreenState extends State<ReservedProviderScreen> {
  var dataoaded;
  List<UserData> usersList = [];
  List<Database> postList = [];

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
            title: const Text("الطلبات المحجوزة"),
            leading: GestureDetector(
              onTap: () {
                _clearAll();
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
                    .collection('foodPost')
                    .where('Cid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where('reserve', isEqualTo: "1")
                    .where('sendExpProvider', isEqualTo: false)
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
                        child: Text(" لا توجد أي حجوزات بعد",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )));
                  } else {
                    QuerySnapshot<Object?>? querySnapshot = snaphot.data;

                    List<dynamic>? allData =
                        querySnapshot?.docs?.map((doc) => doc.data()).toList();

                    _clearAll();

                    for (var element in allData!) {
                      postList.add(Database.foodConstructor(
                        docId: element['docId'],
                        userUid: element['Cid'],
                        userPost: element['userPost'],
                        postTitle: element['postTitle'],
                        postText: element['postText'],
                        postAdress: element['postAdress'],
                        postImage: element['postImage'],
                        postExp: element['postExp'],
                        food_cont: element['food_cont'],
                        providerblocked: element['providerblocked'],
                        reservedby: element["reservedby"],
                        sendExpProvider: element["sendExpProvider"],
                      ));
                    }
                    for (var i = 0; i < usersList.length; i++) {
                      for (var j = 0; j < postList.length; j++) {
                        if (usersList[i].uid == postList[j].reservedby) {
                          postList[j].postUserName = usersList[i].username;
                          postList[j].postEmail = usersList[i].email;
                          postList[j].postPhone = usersList[i].phoneNumber;
                        }
                      }
                    }

                    return ListView.builder(
                      itemCount: snaphot.data?.docs.length,
                      itemBuilder: (context, index) => ProviderRlistCard(
                        //  snap: snaphot.data?.docs[index].data(),
                        postList: postList[index],
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
