import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/Database/database.dart';
import 'package:faydh/ReservedFoodListConsumer.dart';
import 'package:faydh/models/post_model.dart';
import 'package:faydh/services/firestore_methods.dart';
import 'package:faydh/upload_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'models/reported_model.dart';

//import 'package:path/path.dart';

// import 'ReservedFoodListConsumer.dart';
User? Uid = FirebaseAuth.instance.currentUser;

class viewAllFood extends StatefulWidget {
  const viewAllFood({Key? key}) : super(key: key);

  @override
  State<viewAllFood> createState() => _viewAllFood();
}

class _viewAllFood extends State<viewAllFood> {
  TextEditingController _searchTextController = new TextEditingController();
  String filter = "";

  bool arrow = false;

  @override
  initState() {
    super.initState();
    getData();
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

  void reserve({required String id}) async {
    await FirebaseFirestore.instance
        .collection('foodPost')
        .doc(id)
        .update({'reserve': '1'});
    await FirebaseFirestore.instance
        .collection('foodPost')
        .doc(id)
        .update({'reservedby': FirebaseAuth.instance.currentUser?.uid});
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
      //.where('providerblocked', isEqualTo: 'false')
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
        stream: FirebaseFirestore.instance
            .collection('foodPost')
            .where('reserve', isEqualTo: '0')
            .where('providerblocked', isEqualTo: false)
            .where('Cid', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
            // .orderBy("docId",descending: true,)
            .snapshots(),
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
              hintText: 'ابحث عن طعام ....',
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
              : data['postTitle']
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              tweetHeader(
                "${data['postTitle'].toString()}",
                "${data['Cid'].toString()}",
                "${data['docId'].toString()}",
                "${data['postText'].toString()}",
                "${data['postImage'].toString()}",
              ), // so?
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    data['postText'],
                    style: const TextStyle(
                      letterSpacing: 0.2,
                      fontSize: 15,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "موقع الإستلام:  ${data['postAdress'].toString()}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 92, 133, 82),
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
                      color: Color.fromARGB(255, 92, 133, 82),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: SizedBox(
                  width: 250,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.grey,
                        child: Image.network(
                          data['postImage'],
                          height: 180,
                          width: 250,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "تاريخ الانتهاء : ${data['postExp'].toString()}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 92, 133, 82),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "تاريخ الإضافة:  ${data['postDate'].toString().split(" ").first}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 92, 133, 82),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(55, 0, 130, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
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
                        data['docId'].update({
                          'reservedby': FirebaseAuth.instance.currentUser?.uid
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.fromLTRB(45.0, 8.0, 45.0, 8.0),
                        backgroundColor: const Color.fromARGB(255, 18, 57, 20),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        'حــجــز',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  tweetHeader(String u, String c, String doc, String t, String po) {
    // ignore: non_constant_identifier_names

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  u,

                  //  "me",
                  style: const TextStyle(
                      color: Color(0xFF1A4D2E),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                            onTap: (() {}),
                            child: PopupMenuButton(
                                itemBuilder: (ctx) => [
                                      PopupMenuItem(
                                        child: const Text(
                                            'تبليغ محتوى غير لائق',
                                            style:
                                                TextStyle(color: Colors.red)),
                                        onTap: () {
                                          Future.delayed(
                                            const Duration(seconds: 0),
                                            () => showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15.0))),
                                                  title: const Text(
                                                    'تأكيد البلاغ',
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  content: const Text(
                                                    "هل أنت متأكد من التبليغ عن هذا المحتوى ؟ ",
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child:
                                                          const Text("إلغاء"),
                                                      onPressed: () {
                                                        // callback function for on click event of Cancel button
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text("موافق"),
                                                      onPressed: () async {
                                                        var snapss2 = await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'reportedContent')
                                                            .where('userId',
                                                                isEqualTo: c
                                                                    .toString())
                                                            .where('flag',
                                                                isEqualTo: 1)
                                                            .where('postId',
                                                                isEqualTo: doc
                                                                    .toString())
                                                            .get();

                                                        if (snapss2.size == 0) {
                                                          Database2
                                                              .reportedContentData(
                                                            context: context,
                                                            postTitle:
                                                                u.toString(),
                                                            postText:
                                                                t.toString(),
                                                            ReportReason:
                                                                "محتوى غير لائق (اعلان طعام)",
                                                            Cid: c.toString(),
                                                            docId:
                                                                doc.toString(),
                                                            postImage:
                                                                po.toString(),
                                                            flag: 1,
                                                          );
                                                        }

                                                        Navigator.pop(context);

                                                        print("check");
                                                      },
                                                    ),
                                                  ]),
                                            ),
                                          );
                                        },
                                      )
                                    ])),
                      ),
                      const SizedBox(
                        width: 10,
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
