import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/ApproveBusiness.dart';
import 'package:faydh/models/reported_model.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faydh/components/background.dart';

class reportedContent extends StatefulWidget {
  final snap;
  final reported postData;
  //  var id;
  // DocumentReference<Map<String, dynamic>> reference;

  reportedContent(
      {this.snap,
      required this.postData,
      //   required this.id,
      //  required this.reference,
      super.key});

  @override
  State<reportedContent> createState() => _reportedContent();
}

@override
class _reportedContent extends State<reportedContent> {
  String id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 0,
        color: Colors.transparent,

        //  color: Colors.white.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tweetBody(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tweetBody() {
    //var _dta = "${widget.snap["postImage"].toString()}";
    // var _dta = widget.postData.postImage.toString();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 2, bottom: 2, left: 2),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20, right: 0, bottom: 2, left: 50),
              child: Text(
                  //"${widget.snap["postText"].toString()}",
                  " اسم المستخدم" +
                      " : " +
                      widget.postData.postUserName.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 2, bottom: 2, left: 2),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 2, right: 0, bottom: 2, left: 50),
              child: Text(
                  //"${widget.snap["postText"].toString()}",
                  " البريد الإلكتروني" +
                      " : " +
                      widget.postData.postEmail.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(125, 158, 158, 158),
                      spreadRadius: 0.01,
                      blurRadius: 15)
                ]),
                child: widget.postData.flag != 2?
                 GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "تأكيد ",
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
                                    //     widget.reference.delete();
                                    print(widget.postData.Rid.toString());
                                    FirebaseFirestore.instance
                                        .collection('reportedContent')
                                        .doc(widget.postData.Rid.toString())
                                        .delete();

                                    //   print(widget.id.toString());
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(
                          size: 10,
                          Icons.check_box_outlined,
                          color: Colors.green,
                        ),
                        Text(' محتوى غير مخالف  '),
                      ],
                    )):
                    GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "تأكيد ",
                                textAlign: TextAlign.right,
                              ),
                              content: const Text(
                                "هل أنت متأكد من أن المستخدم غير مخالف ؟ ",
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
                                    //     widget.reference.delete();
                                    print(widget.postData.Rid.toString());
                                    FirebaseFirestore.instance
                                        .collection('reportedContent')
                                        .doc(widget.postData.Rid.toString())
                                        .delete();

                                         FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.postData.userId.toString())
                                        .update({'ReportCount': FieldValue.increment(-1)});

                                    //   print(widget.id.toString());
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(
                          size: 10,
                          Icons.check_box_outlined,
                          color: Colors.green,
                        ),
                        Text(' المستخدم غير مخالف  '),
                      ],
                    ))
              ),
              Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(124, 26, 25, 25),
                      spreadRadius: 0.01,
                      blurRadius: 30)
                ]),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
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
                                    Navigator.pop(context);
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.postData.userId.toString())
                                        .update({'Active': false});
                                    Navigator.pop(context);

                                 
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(
                          size: 20,
                          Icons.block,
                          color: Colors.red,
                        ),
                        Text(' حظر المستخدم   '),
                      ],
                    )),
              ),

              Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(125, 158, 158, 158),
                      spreadRadius: 0.01,
                      blurRadius: 15)
                ]),
                child: widget.postData.flag != 2?
                 GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "تأكيد حذف المحتوى من الجميع",
                                textAlign: TextAlign.right,
                              ),
                              content: const Text(
                                "هل أنت متأكد من حذف المحتوى من الجميع  ؟ ",
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
                                    if (widget.postData.flag == 0) {
                                      FirebaseFirestore.instance
                                          .collection('post')
                                          .doc(
                                              widget.postData.postId.toString())
                                          .delete();
                                    } else if (widget.postData.flag == 1) {
                                      FirebaseFirestore.instance
                                          .collection('foodPost')
                                          .doc(
                                              widget.postData.postId.toString())
                                          .delete();
                                    }

                                    FirebaseFirestore.instance
                                        .collection('reportedContent')
                                        .doc(widget.postData.Rid.toString())
                                        .delete();

                                    print("check");
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(
                          size: 20,
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        Text('  حذف المحتوى    '),
                      ],
                    )):
                    const Text("")
                  
              
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),

      /* if (_dta.isNotEmpty)
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
            ),*/
    );
  }

  Widget tweetHeader() {
    var cardId = widget.postData.userId.toString();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.postData.ReportReason.toString(),

                  //  "me",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 249, 9, 9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        //  Spacer(),
      ],
    );

    /*
   // var _dta = "${widget.snap["pathImage"].toString()}";

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

                               //  FirebaseFirestore.instance.collection('users').doc(id).delete();

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
  }*/
  }
}
