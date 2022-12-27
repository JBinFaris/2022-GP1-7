import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/Database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ReservedConsumerScreen extends StatefulWidget {
  const ReservedConsumerScreen({Key? key}) : super(key: key);

  @override
  State<ReservedConsumerScreen> createState() => _ReservedConsumerScreenState();
}

class _ReservedConsumerScreenState extends State<ReservedConsumerScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> foodPostStream = FirebaseFirestore.instance
        .collection('foodPost')
        .where('reserve', isEqualTo: "1")
        .snapshots();

    return Scaffold(
      backgroundColor: Color(0xffd6ecd0),
      appBar: AppBar(
          elevation: 2.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF1A4D2E),
          title: const Text("طلباتي المحجوزة"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Color.fromARGB(225, 255, 255, 255),
            ),
          )),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.9],
              colors: [Color.fromARGB(142, 26, 77, 46), Color(0xffd6ecd0)]),
        ),
      ),
    );
  }
}
