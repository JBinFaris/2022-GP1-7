import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faydh/services/firestore_methods.dart';

import 'package:url_launcher/url_launcher.dart';

String id = FirebaseAuth.instance.currentUser!.uid;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

@override
void initState() {
  //getUser2();
}

String? usrEmail;
String? usrNamee;
String? phonee;
String? consId;

class ProviderRlistCard extends StatefulWidget {
  final postList;
  //final snap;
//  final UserData ConsData;
  const ProviderRlistCard({
    this.postList,
    //this.snap,
    super.key,
    // required this.ConsData,
  });

  @override
  State<ProviderRlistCard> createState() => _ProviderRlistCardState();
}

class _ProviderRlistCardState extends State<ProviderRlistCard> {
  String myUsername = "";
  var seen = false;

  @override
  Widget build(BuildContext context) {
    usrEmail = widget.postList.postEmail.toString();
    usrNamee = widget.postList.postUserName.toString();
    phonee = widget.postList.postPhone.toString();
    //consId = ("${widget.snap["reservedby"].toString()}");

    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    // _getUserData();
    //print(proId);

    /*return FutureBuilder<DocumentSnapshot>(
      future: users.doc("${widget.snap["reservedby"]}").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        try {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            //  return Text("Full Name: ${data['full_name']} ${data['last_name']}");
            phonee = (" ${data['phoneNumber']}");
            usrEmail = (" ${data['email']}");
            usrNamee = (" ${data['username']}");
          }
        } catch (e) {
          print(e.toString());
        }*/

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        /*  shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0,
            color: Colors.white,
          ),
        ),*/
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tweetAvatar(),
                  tweetBody(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                            "تأكيد الإستلام",
                                            textAlign: TextAlign.right,
                                          ),
                                          content: const Text(
                                            (" هل تم إستلام الطعام من قبل الحاجز ؟ "),
                                            textAlign: TextAlign.right,
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("لا"),
                                              onPressed: () {
                                                // callback function for on click event of Cancel button
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text("نعم"),
                                              onPressed: () async {
                                                _firestore
                                                    .collection("foodPost")
                                                    .doc(
                                                        "${widget.postList.docId.toString()}")
                                                    .delete();

                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .update({
                                                  "reserveCount":
                                                      FieldValue.increment(1)
                                                });

                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 8.0, 20.0, 8.0),
                                  backgroundColor: const Color(0xFF1A4D2E),
                                  shape: const StadiumBorder(),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Icon(
                                        // <-- Icon
                                        Icons.check_box,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "تأكيد الإستلام",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                            "تأكيد الغاء الحجز",
                                            textAlign: TextAlign.right,
                                          ),
                                          content: const Text(
                                            (" هل أنت متأكد من الغاء الحجز ؟ "),
                                            textAlign: TextAlign.right,
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("لا"),
                                              onPressed: () {
                                                // callback function for on click event of Cancel button
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text("نعم"),
                                              onPressed: () async {
                                                Navigator.pop(context);

                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SimpleDialog(
                                                        title: const Text(
                                                          ("سبب الغاء الحجز"),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                        children: <Widget>[
                                                          SimpleDialogOption(
                                                            onPressed: () {
                                                              _firestore
                                                                  .collection(
                                                                      "foodPost")
                                                                  .doc(widget
                                                                      .postList
                                                                      .docId
                                                                      .toString())
                                                                  .update({
                                                                "reserve": "0"
                                                              });

                                                              _firestore
                                                                  .collection(
                                                                      "foodPost")
                                                                  .doc(widget
                                                                      .postList
                                                                      .docId
                                                                      .toString())
                                                                  .update({
                                                                "notifyCancelC":
                                                                    "0"
                                                              });

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'لا ارغب بالتبرع'),
                                                          ),
                                                          SimpleDialogOption(
                                                            onPressed: () {
                                                              _firestore
                                                                  .collection(
                                                                      "foodPost")
                                                                  .doc(widget
                                                                      .postList
                                                                      .docId
                                                                      .toString())
                                                                  .update({
                                                                "reserve": "0"
                                                              });

                                                              _firestore
                                                                  .collection(
                                                                      "foodPost")
                                                                  .doc(widget
                                                                      .postList
                                                                      .docId
                                                                      .toString())
                                                                  .update({
                                                                "reservedby":
                                                                    null,
                                                              });

                                                              _firestore
                                                                  .collection(
                                                                      "foodPost")
                                                                  .doc(widget
                                                                      .postList
                                                                      .docId
                                                                      .toString())
                                                                  .update({
                                                                "notifyCancelC":
                                                                    "0"
                                                              });

                                                              _firestore
                                                                  .collection(
                                                                      "users")
                                                                  .doc(widget
                                                                      .postList
                                                                      .reservedby
                                                                      .toString())
                                                                  .update({
                                                                "ReportCount":
                                                                    FieldValue
                                                                        .increment(
                                                                            1)
                                                              });

                                                              CheckReportCount(
                                                                  widget
                                                                      .postList
                                                                      .reservedby
                                                                      .toString());

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'المستفيد لايستجيب'),
                                                          ),
                                                        ],
                                                      );
                                                    });

                                                print("check");
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(29, 8.2, 29, 8),
                                  //  backgroundColor: Color.fromARGB(255, 194, 5, 5),
                                  backgroundColor:
                                      const Color.fromARGB(255, 194, 5, 5),
                                  shape: const StadiumBorder(),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Icon(
                                        // <-- Icon
                                        Icons.disabled_by_default,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "الغاء الحجز",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //
    //  },
    //  );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.account_circle_rounded,
          color: Color.fromARGB(226, 29, 92, 76),
          size: 40,
        ),
      ),
    );
  }

  Widget tweetBody() {
    //var _dta = "${widget.snap["postImage"].toString()}";
    return Expanded(
      child: Column(
        children: [
          tweetHeader(" ${phonee!}", " ${usrNamee!}"),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 0, bottom: 2, left: 2),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15, right: 0, bottom: 2, left: 50),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${/*" نوع الطعام: " + */ widget.postList.postTitle.toString()}"),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${/*" نوع الطعام: " + */ widget.postList.postText.toString()}"),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                            //fontSize: 18,
                          ))),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text((" رقم الحاجز : ${phonee}"),
                        // " رقم للحاجز ",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 92, 133, 82),

                          // color: Colors.black,
                          //fontWeight: FontWeight.bold,
                        )),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" موقع الإستلام: " + widget.postList.postAdress.toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 92, 133, 82),

                            // fontWeight: FontWeight.bold,
                          ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" كمية الطعام: " + widget.postList.food_cont.toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 92, 133, 82),

                            // fontWeight: FontWeight.bold,
                          ))),
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
                              widget.postList.postImage.toString(),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "تاريخ الانتهاء : ${widget.postList.postExp.toString()}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 92, 133, 82),
                          fontSize: 12,
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget tweetHeader(String pp, String nn) {
    //final Uri whatsapp = Uri.parse("https://wa.me/${phone!}");
    //final Uri call = Uri.parse("tel://${phone!}");

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
                  nn,
                  //  "me",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          onTap: (() {
                            // ignore: deprecated_member_use
                            launch('https://wa.me/' + pp);
                          }),
                          child: const Icon(
                            Icons.whatsapp,
                            size: 25,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // ignore: deprecated_member_use
                          launch("tel://" + pp);
                          print(phonee);
                        },
                        child: const Icon(
                          Icons.call,
                          size: 25,
                          color: Colors.green,
                        ),
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

  void CheckReportCount(String s) async {
    var snapss =
        await FirebaseFirestore.instance.collection('users').doc(s).get();

    if (snapss.exists) {
      Map<String, dynamic>? data = snapss.data();

      var count = data!["ReportCount"];

      if (count >= 3) {
        var snapss2 = await FirebaseFirestore.instance
            .collection('reportedContent')
            .where('userId', isEqualTo: s)
            .where('flag', isEqualTo: 2)
            .get();

        var userinfosnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();

        Map<String, dynamic>? uinfo = userinfosnap.data();

        var username = uinfo!["username"];

        var alldocs = snapss2.docs;

        var user = username;

        if (snapss2.size == 0) {
          FirestoreMethods().uploadReport(
            ReportReason: 'عدم الاستجابه عدة مرات',
            userId: s,
            flag: 2,
            reportCount: 1,
            Reporters: [user],
          );
        } else {
          for (var i = 0; i < snapss2.size; i++) {
            FirebaseFirestore.instance
                .collection('reportedContent')
                .doc(alldocs[i]["Rid"])
                .update({
              "Reporters": FieldValue.arrayUnion([user])
            });
            FirebaseFirestore.instance
                .collection('reportedContent')
                .doc(alldocs[i]["Rid"])
                .update({"reportCount": FieldValue.increment(1)});
          }
        }
      }
    }
  }
}
