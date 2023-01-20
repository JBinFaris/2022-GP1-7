import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/ApproveBusiness.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faydh/components/background.dart';

class reportedContent extends StatefulWidget {
  const reportedContent({super.key});
  @override
  State<reportedContent> createState() => _reportedContent();
}

@override
class _reportedContent extends State<reportedContent> {
  String id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> foodPostStream = FirebaseFirestore.instance
        .collection('foodPost')
        .where('reserve', isEqualTo: '0')
        // .orderBy("docId",descending: true,)
        .snapshots();

    return Scaffold(
        /*
      backgroundColor: Colors.green[100],

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
                child: Text("! لم تقم بنشر تبرعات بعد",
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    elevation: 4.0,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                        ),
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
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "تاريخ الانتهاء : ${data['postExp'].toString()}",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 144, 177, 135),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
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
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    if (data["reserve"] == '0') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditPostNew(
                                                  newID: document.id,
                                                  title: "${data["postTitle"]}",
                                                  address:
                                                      "${data["postAdress"]}",
                                                  text: "${data["postText"]}",
                                                  count: "${data["food_cont"]}",
                                                  expireDate:
                                                      "${data["postExp"]}",
                                                  imgUrl:
                                                      "${data["postImage"]}",
                                                  path: "${data["pathImage"]}",
                                                  reference: document.reference
                                                      as DocumentReference<
                                                          Map<String, dynamic>>,
                                                )),
                                      );
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Text(
                                                  ' الطعام محجوز',
                                                  textAlign: TextAlign.right,
                                                ),
                                                content: const Text(
                                                  " لا يمكن تعديل على الطعام المحجوز",
                                                  textAlign: TextAlign.right,
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text("حسنا"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ]);
                                          });
                                    }
                                  },
                                  child: data["reserve"] == '0'
                                      ? const Icon(
                                          Icons.edit,
                                          color:
                                              Color.fromARGB(226, 29, 92, 76),
                                        )
                                      : const Icon(
                                          Icons.edit,
                                          color: Color.fromARGB(
                                              225, 101, 109, 107),
                                        )),
                              GestureDetector(
                                  onTap: () {
                                    if (data["reserve"] == '0') {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Text(
                                                  'تأكيد الحذف',
                                                  textAlign: TextAlign.right,
                                                ),
                                                content: const Text(
                                                  "هل أنت متأكد من حذف المحتوى ؟ ",
                                                  textAlign: TextAlign.right,
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text("إلغاء"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text("موافق"),
                                                    onPressed: () async {
                                                      print(document.id
                                                          .toString());

                                                      document.reference
                                                          .delete();

                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ]);
                                          });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Text(
                                                  ' الطعام محجوز',
                                                  textAlign: TextAlign.right,
                                                ),
                                                content: const Text(
                                                  " لا يمكن حذف الطعام المحجوز",
                                                  textAlign: TextAlign.right,
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text("حسنا"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ]);
                                          });
                                    }
                                  },
                                  child: data["reserve"] == '0'
                                      ? const Icon(
                                          Icons.delete,
                                          color: Color.fromARGB(255, 172, 8, 8),
                                        )
                                      : const Icon(
                                          Icons.delete,
                                          color: Color.fromARGB(
                                              225, 101, 109, 107),
                                        ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mySheet(context);
          setState(() {
            selectedValue = null;
          });
        },
        backgroundColor: const Color(0xFF1A4D2E),
        child: const Icon(Icons.add),
      ),*/
        );
  }
}
