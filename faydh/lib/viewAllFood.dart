import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/Database/database.dart';
import 'package:faydh/ReservedFoodListConsumer.dart';
import 'package:faydh/upload_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

// import 'ReservedFoodListConsumer.dart';
User? Uid = FirebaseAuth.instance.currentUser;

class viewAllFood extends StatefulWidget {
  const viewAllFood({Key? key}) : super(key: key);

  @override
  State<viewAllFood> createState() => _viewAllFood();
}

class _viewAllFood extends State<viewAllFood> {
  bool arrow = false;

  @override
  initState() {
    super.initState();
    getData();
  }

  void reserve({required String id}) async {
    await FirebaseFirestore.instance
        .collection('foodPost')
        .doc(id)
        .update({'reserve': '1'});
    await FirebaseFirestore.instance
        .collection('foodPost')
        .doc(id)
        .update({'reservedby': Uid});
  }

  Future<String?> getData() async {
    var a = await FirebaseFirestore.instance
        .collection("users")
        .doc(Uid!.uid)
        .get();

    final myrole = a['role'];
    if (myrole == "فرد") {
      setState(() {
        arrow = true;
      });
    }
  }

  //Future sortData() async {}

  final Stream<QuerySnapshot> foodPostStream = FirebaseFirestore.instance
      .collection('foodPost')
      .where('reserve', isEqualTo: '0')
      .where('Cid', isNotEqualTo: Uid!.uid.toString())
      // .orderBy("docId",descending: true,)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    // print("cehecl");

    // print("collection lenG: ${foodPostStream.length}");
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: arrow
          ? AppBar(
              elevation: 2.0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF1A4D2E),
              title: const Text(" إعلانات المتبرعين     "),
              actions: <Widget>[
                SizedBox(
                    width: 130,
                    height: 130,
                    child: FittedBox(
                      child: FloatingActionButton.extended(
                        heroTag: "btn1",
                        label: const Text(
                          'طلباتي المحجوزة',
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
                              return const ReservedConsumerScreen();
                            }),
                          );
                        },
                      ),
                    ))
              ],
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color.fromARGB(225, 255, 255, 255),
                ),
              ))
          : AppBar(
              elevation: 2.0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF1A4D2E),
              title: const Center(child: Text('           إعلانات المتبرعين')),
              actions: <Widget>[
                SizedBox(
                    width: 130,
                    height: 130,
                    child: FittedBox(
                      child: FloatingActionButton.extended(
                        heroTag: "btn1",
                        label: const Text(
                          'طلباتي المحجوزة',
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
                              return const ReservedConsumerScreen();
                            }),
                          );
                        },
                      ),
                    ))
              ],
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
          if (snapshot.hasData && snapshot.data?.size == 0) {
            return const Center(
                child: Text("! لا توجد إعلانات منشورة",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )));
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                //bool b = data['Cid'] != Uid;

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
                                "نوع الطعام:  ${data['postTitle'].toString()}",
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
                                "موقع الإستلام:  ${data['postAdress'].toString()}",
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
                                "كمية الطعام:  ${data['food_cont'].toString()}",
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
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, bottom: 8),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "تاريخ الإضافة:  ${data['postDate'].toString().split(" ").first}",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 177, 135),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 80, 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    /* Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return const viewAllFood();
                                      }),
                                    );*/
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: const Text(
                                                'لقد تم حجز الطعام',
                                                textAlign: TextAlign.right,
                                              ),
                                              content: const Text(
                                                "لمشاهدة الطعام المحجوز او لالغاء الحجز انتقل الى قائمة حجوزاتي",
                                                textAlign: TextAlign.right,
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text("حسنا"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ]);
                                        });
                                    data['docId'].toString();
                                    reserve(id: data['docId'].toString());
                                    data['docId'].update({'notify': '0'});
                                    data['docId'].update({'reservedby': Uid});
                                  },
                                  child: const Text('حجز'),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: const Color(0xFF1A4D2E),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0,
                                      ),
                                      textStyle: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                          /* ElevatedButton(
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
                          ),*/
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
