import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/ApproveBusiness.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faydh/components/background.dart';

class reportedContent extends StatefulWidget {
  final snap;
  var id;
  DocumentReference<Map<String, dynamic>> reference;

  reportedContent(
      {required this.snap,
      required this.id,
      required this.reference,
      super.key});

  @override
  State<reportedContent> createState() => _reportedContent();
}

@override
class _reportedContent extends State<reportedContent> {
  String id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    var _dta = "${widget.snap["pathImage"].toString()}";

    return Directionality(
      textDirection: TextDirection.rtl,
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
                  ("${" المحتوى: " + widget.snap["postText"].toString()}"),
                  style: const TextStyle(
                    color: Color(0xFF1A4D2E),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            // data['pathImage'],
            const SizedBox(height: 3),
            if (_dta.isNotEmpty)
              SizedBox(
                width: 250,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.grey,
                      child: Image(
                        image: NetworkImage(_dta),
                        fit: BoxFit.cover,
                        height: 150,
                        width: 250,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text(
                                'تأكيد ',
                                textAlign: TextAlign.right,
                              ),
                              content: const Text(
                                "هل أنت متأكد من أن المحتوى غير مخالف ؟ ",
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
                                    widget.reference.delete();

                                    print(widget.id.toString());

                                    Navigator.pop(context);

                                    print("check");
                                  },
                                ),
                              ]);
                        });
                  },
                  child: const Text('محتوى غير مخالف',
                      style: TextStyle(color: Colors.red)),
                ),
                InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text(
                                'تأكيد ',
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
                                  onPressed: () {
                                    //ناخذ من مودل جمانه عشان فلاق البلوك لليوزر
                                  },
                                ),
                              ]);
                        });
                  },
                  child: const Text('حظر المستخدم',
                      style: TextStyle(color: Colors.red)),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(' حذف المحتوى من الجميع',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );

    /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          mySheet(context);
          setState(() {
            selectedValue = null;
          });
        },
        backgroundColor: const Color(0xFF1A4D2E),
        child: const Icon(Icons.add),
      ), */
  }
}
