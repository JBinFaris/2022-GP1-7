import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/services/firestore_methods.dart';
import 'package:faydh/widgets/ProviderRListCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

String id = FirebaseAuth.instance.currentUser!.uid;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

@override
void initState() {
  String id = FirebaseAuth.instance.currentUser!.uid;
  //getData2(proId!);
  //getUser2();
  // TODO: implement initState
}

String? usrEmail;
String? usrName;
String? phone;
String? proId;

//Future<String?> getData2(String proId) async {
//print(proId);
// var a = await FirebaseFirestore.instance.collection('users').doc(proId).collection("phoneNumber").get();
// usrEmail = a['email'];
//  usrName = a['username'];
// phoneNo = a['phoneNumber'];
//}

class ConsumerListCard extends StatefulWidget {
  final snap;
  final postList;
  const ConsumerListCard({
    this.snap,
    this.postList,
   super.key});

  @override
  State<ConsumerListCard> createState() => _ConsumerListCardState();
}

class _ConsumerListCardState extends State<ConsumerListCard> {
  String myUsername = "";
  var seen = false;
  @override
  Widget build(BuildContext context) {
  usrEmail = widget.postList.postEmail.toString();
usrName= widget.postList.postUserName.toString();
 phone= widget.postList.postPhone.toString();
  //  proId = ("${widget.snap["Cid"].toString()}");
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //print(proId);
   /* return FutureBuilder<DocumentSnapshot>(
      future: users.doc("${widget.snap["Cid"].toString()}").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          //  return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          phone = (" ${data['phoneNumber']}");
          usrEmail = (" ${data['email']}");
          usrName = (" ${data['username']}");
        }*/
        // print(usrEmail);
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
            ), */
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
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(125, 158, 158, 158),
                                spreadRadius: 0.3,
                                blurRadius: 15)
                          ]),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
                                                  return  SimpleDialog(
                                                    title: Text(
                                                      ("سبب الغاء الحجز"),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    children: <Widget>[
                                                      SimpleDialogOption(
                                                        onPressed: () {
                                                            _firestore
                                                .collection("foodPost")
                                                .doc(widget.postList.docId.toString())
                                                .update({"reserve": "0"});

                                                        Navigator.pop(context);

                                                        },
                                                        child:  Text(
                                                            'لا ارغب بالطعام'),
                                                      ),
                                                      SimpleDialogOption(
                                                        onPressed: () {
                                                            _firestore
                                                .collection("foodPost")
                                                .doc(widget.postList.docId.toString())
                                                .update({"reserve": "0"});

                                                        //  print(widget.postList.userUid);
                                                           _firestore
                                                .collection("users")
                                                .doc(widget.postList.userUid.toString())
                                                .update({"ReportCount": FieldValue.increment(1)});

                                                 CheckReportCount2(widget.postList.userUid.toString());
                                                   Navigator.pop(context);

 },
                                                        child: const Text(
                                                            'المتبرع لايستجيب'),
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
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.disabled_by_default,
                                      color: Colors.red,
                                    ),
                                    Text("الغاء الحجز"),
                                  ],
                                )),
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
      }
   // );
  //}

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
    // final Uri phone = Uri.parse("tel:0535603046");
    // final Uri whatsApp = Uri.parse('https://wa.me/0535603046');
    //print(whatsApp);
    // var _dta = "${widget.snap["postImage"].toString()}";
    return Expanded(
      child: Column(
        children: [
          //  tweetLeft(),
          tweetHeader(" ${phone!}", " ${usrName!}"),
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
                          ("${/*" نوع الطعام: " + */widget.postList.postTitle.toString()}"),
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
                    child: Text((" رقم المتبرع : ${phone!}"),

                        // " رقم للحاجز ",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                        )),
                  ),
                  /*  Align(
                      alignment: Alignment.centerRight,
                      child: Text((" البريد الإلكتروني للمتبرع : ${usrEmail!}"),
                          // " البريد الإلكتروني للحاجز ",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))), */

                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" موقع الإستلام: " + widget.postList.postAdress.toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            //  fontWeight: FontWeight.bold,
                          ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          ("${" كمية الطعام: " + widget.postList.food_cont.toString()}"),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.black,
                            //  fontWeight: FontWeight.bold,
                          ))),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          widget.postList.postImage.toString(),
                          height: 250,
                          width: 170,
                          //   fit: BoxFit.contain,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "تاريخ الانتهاء : ${widget.postList.postExp.toString()}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 144, 177, 135),
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

  Widget tweetHeader(String p, String n) {
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
                  n,
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
                            launch('https://wa.me/' + p);
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
                          launch("tel://" + p);
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
   void CheckReportCount2(String s) async{

   var snapss = await FirebaseFirestore.instance.collection('users').doc(s).get();

    if (snapss.exists) {
      Map<String, dynamic>? data = snapss.data();

      var count = data!["ReportCount"];

      if(count >= 3){
     FirestoreMethods().uploadReport(ReportReason:'عدم الاستجابه عدة مرات',userId: s, flag: 2)  ; 
     
        }
    }



  }

}
/*
tweetLeft() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: (() async {
            launchUrl(whatsApp);
          }),
          child: const Icon(
            Icons.whatsapp,
            size: 35,
            color: Colors.green,
          ),
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: (() async {
            print(await canLaunchUrl(phone));
          }),
          child: const Icon(
            Icons.call,
            size: 35,
            color: Colors.green,
          ),
        ),
      )
    ],
  );
}
*/