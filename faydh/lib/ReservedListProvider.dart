import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/Database/database.dart';
import 'package:faydh/widgets/ProviderRListCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'models/user_data_model.dart';

class ReservedProviderScreen extends StatefulWidget {
  const ReservedProviderScreen({Key? key}) : super(key: key);

  @override
  State<ReservedProviderScreen> createState() => _ReservedProviderScreenState();
}

String id = FirebaseAuth.instance.currentUser!.uid;

class _ReservedProviderScreenState extends State<ReservedProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffd6ecd0),
        appBar: AppBar(
            elevation: 2.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF1A4D2E),
            title: const Text("الطلبات المحجوزة"),
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
                    .collection('foodPost')
                    .where('Cid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where('reserve', isEqualTo: "1")
                    .orderBy(
                      "docId",
                      descending: true,
                    )
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
                  }

                  return ListView.builder(
                    itemCount: snaphot.data?.docs.length,
                    itemBuilder: (context, index) => ProviderRlistCard(
                      snap: snaphot.data?.docs[index].data(),
                    ),
                  );
                }),
          ),
        ));
  }
}
