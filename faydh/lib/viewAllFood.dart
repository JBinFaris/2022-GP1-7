import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/Database/database.dart';
import 'package:faydh/upload_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

class viewAllFood extends StatefulWidget {
  const viewAllFood({Key? key}) : super(key: key);

  @override
  State<viewAllFood> createState() => _viewAllFood();
}

class _viewAllFood extends State<viewAllFood> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> foodPostStream =
        FirebaseFirestore.instance.collection('foodPost').snapshots();

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: const Color(0xFF1A4D2E),
        title: const Text("اعلانات المتبرعين"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: foodPostStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('حدث خطأ ما');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading..."));
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    elevation: 4.0,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(),
                          ), // so?
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                data['postTitle'],
                                style: const TextStyle(
                                  color: Color(0xFF1A4D2E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                data['postAdress'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 144, 177, 135),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                data['food_cont'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 144, 177, 135),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                data['postText'],
                                style: const TextStyle(
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Image.network(
                              data['postImage'],
                              height: 200,
                              width: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, bottom: 8),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "تاريخ الانتهاء : ${data['postExp'].toString()}",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 177, 135),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 12, bottom: 8),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "تاريخ الاضافة : ${data['postExp'].toString()}",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 144, 177, 135),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return const viewAllFood();
                                }),
                              );
                            },
                            child: const Text('حجز'),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: const Color(0xFF1A4D2E),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                textStyle: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
