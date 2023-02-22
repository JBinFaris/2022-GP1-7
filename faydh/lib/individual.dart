import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/FoodPost.dart';
import 'package:faydh/viewAllFood.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:faydh/components/background.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'forget-password.dart';

import 'package:intl/intl.dart';
import 'dart:async';

class individual extends StatefulWidget {
  const individual({super.key});
  @override
  State<individual> createState() => _individualPageState();
}

@override
class _individualPageState extends State<individual> {
  String? mtoken = "";

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void getToken({required id}) async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('my token is $mtoken');
      });
      var period = const Duration(hours: 1);
      Timer.periodic(period, (arg) {
        print('inside save token');
        saveToken(id: FirebaseAuth.instance.currentUser!.uid, token: token!);
      });
      saveToken(id: FirebaseAuth.instance.currentUser!.uid, token: token!);
    });
  }

  void saveToken({required String id, required String token}) async {
    /* await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'token': token});}*/

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    DateTime dt1Now = DateTime.parse(formattedDate);
    print("formattttt");
    print(formattedDate);
    FirebaseFirestore.instance
        .collection('foodPost')
        .where('Cid', isEqualTo: id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        var raw_date = doc["postExp"].toString().split('-');
        DateTime dt2check = DateTime(int.parse('${raw_date[0]}'),
            int.parse('${raw_date[1]}'), int.parse('${raw_date[2]}'));
        String exp = doc["postExp"];

        print(exp);
        if (dt1Now.isAfter(dt2check)) {
          if (doc["sendExpProvider"] == false) {
            print('bbbbbbbbbbbbbb');
            FirebaseFirestore.instance
                .collection('foodPost')
                .doc(doc["docId"])
                .update({'sendExpProvider': true});
            Future.delayed(const Duration(seconds: 2), () {
              print("expired");
              initInfo();
              sendPushMessage(
                  token: token, title: "طعام منتهي", text: doc["postTitle"]);
            });
          }
          var snapp = await FirebaseFirestore.instance
              .collection('foodPost')
              .doc(doc["docId"])
              .get();

          if (snapp.exists) {
            Map<String, dynamic>? data = snapp.data();

            var sendExpConsumer = data!["sendExpConsumer"];
            var sendExpProvider = data!["sendExpProvider"];
            if (doc['reserve'] == 1) {
              if (sendExpProvider == true && sendExpConsumer == true) {
                FirebaseFirestore.instance
                    .collection('foodPost')
                    .doc(doc["docId"])
                    .delete();
              }
            } else {
              FirebaseFirestore.instance
                  .collection('foodPost')
                  .doc(doc["docId"])
                  .delete();
            }
          }
        } //end if
        if (doc["reserve"] == '1' && doc["notify"] == '0') {
          print('notify');
          Future.delayed(const Duration(seconds: 5), () {
            initInfo();
            sendPushMessage(
                token: token, title: " طعام محجوز ", text: doc["postTitle"]);
          });
          FirebaseFirestore.instance
              .collection('foodPost')
              .doc(doc["docId"])
              .update({'notify': '1'});
        }

        if (doc["reserve"] == '1' && doc["providerblocked"] == true) {
          print('notify');
          Future.delayed(const Duration(seconds: 7), () {
            initInfo();
            sendPushMessage(
                token: token,
                title: " حاجز الطعام محظور ",
                text: doc["postTitle"]);
          });
          FirebaseFirestore.instance
              .collection('foodPost')
              .doc(doc["docId"])
              .update({'reserve': '0'});
        }

        if (doc["notifyCancelP"] == '0') {
          print('notifyCancelP');
          Future.delayed(const Duration(seconds: 5), () {
            initInfo();
            sendPushMessage(
                token: token, title: " طعام ملغى ", text: doc["postTitle"]);
          });
          FirebaseFirestore.instance
              .collection('foodPost')
              .doc(doc["docId"])
              .update({'notifyCancelP': '1'});
        }
      });
    });

    FirebaseFirestore.instance
        .collection('foodPost')
        .where('reservedby', isEqualTo: id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc["notifyCancelC"] == '0') {
          print('notifyCancelC');
          Future.delayed(const Duration(seconds: 5), () {
            initInfo();
            sendPushMessage(
                token: token, title: " طعام ملغى ", text: doc["postTitle"]);
          });
          FirebaseFirestore.instance
              .collection('foodPost')
              .doc(doc["docId"])
              .update({'notifyCancelC': '1'});
        }
        var raw_date = doc["postExp"].toString().split('-');
        DateTime dt2check = DateTime(int.parse('${raw_date[0]}'),
            int.parse('${raw_date[1]}'), int.parse('${raw_date[2]}'));

        if (dt1Now.isAfter(dt2check)) {
          if (doc["sendExpConsumer"] == false) {
            print('bbbbbbbbbbbbbb');
            FirebaseFirestore.instance
                .collection('foodPost')
                .doc(doc["docId"])
                .update({'sendExpConsumer': true});
            Future.delayed(const Duration(seconds: 2), () {
              print("expired");
              initInfo();
              sendPushMessage(
                  token: token, title: "طعام منتهي", text: doc["postTitle"]);
            });
          }
          var snapp = await FirebaseFirestore.instance
              .collection('foodPost')
              .doc(doc["docId"])
              .get();

          if (snapp.exists) {
            Map<String, dynamic>? data = snapp.data();

            var sendExpConsumer = data!["sendExpConsumer"];
            var sendExpProvider = data!["sendExpProvider"];
            if (sendExpProvider == true && sendExpConsumer == true) {
              FirebaseFirestore.instance
                  .collection('foodPost')
                  .doc(doc["docId"])
                  .delete();
            }
          }
        }
      });
    });

    FirebaseFirestore.instance
        .collection('foodPost')
        .where('reservedby', isEqualTo: id)
        .where('providerblocked', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String title = doc["postTitle"].toString();
        // String send = title + '';

        Future.delayed(const Duration(seconds: 5), () {
          initInfo();
          sendPushMessage(
              token: token,
              title:
                  "  عذرا الطعام المحجوز تم حذفه من قبل المشرف لانتهاكه سياسة الاستخدام     ",
              text: title);
        });

        FirebaseFirestore.instance
            .collection('foodPost')
            .doc(doc["docId"])
            .delete();
      });
    });
  }

  void initInfo() async {
    var id = 0;
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    //var iosInitialize =const IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatContent: true,
      );
      AndroidNotificationDetails androidPlatformChanelSpecifics =
          AndroidNotificationDetails(
        'adfood',
        'adfood',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );

      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChanelSpecifics);

      await flutterLocalNotificationsPlugin.show(
          id++,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics);
    });
  }

  void sendPushMessage(
      {required String token,
      required String title,
      required String text}) async {
    print(title + '.....' + text);

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA5LB0-7Q:APA91bGe0F1hMmg6Hh8MNQjGBTzyvxZyz-HInHqaWWg5MJ6LmKUNTAPPURXthsQfVxCNTUVhm90czUeMdUFcHCOlFr_XPqbKt7-Z7dRf3xXl3Bt6W7Cul94feW1ObmMoXnMEGw6_y0Hl',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'Flutter_Notification_Click',
              'status': 'done',
              'body': text,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": text,
              "android_channel_id": "dbfood",
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('error notification');
      }
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    getToken(id: FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
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
                  Color.fromARGB(0, 26, 77, 46),
                  Color.fromARGB(17, 214, 236, 208)
                ]),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
          child: Column(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: ClipOval(
                child: Image.asset(
                  'assets/imgs/logo.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: 250,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      backgroundColor: const Color.fromARGB(255, 18, 57, 20),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const FoodPostScreen();
                      }));
                    },
                    child: const Text(
                      "متبرع",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20),
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: 250,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      backgroundColor: const Color.fromARGB(255, 18, 57, 20),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const viewAllFood();
                        }),
                      );
                    },
                    child: const Text(
                      "مستفيد",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20),
                    ),
                  )),
            ),
            /*  Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: AnimatedButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Icon(Icons.person, color: Colors.white),
                            Text("متبرع",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const FoodPostScreen();
                          }));
                        },
                        type: null,
                        height: 70,
                        width: 300,
                        borderRadius: 30,
                        color: Color.fromARGB(255, 62, 112, 82),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AnimatedButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //   const Icon(Icons.person, color: Colors.white),
                            Text("مستفيد",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const viewAllFood();
                            }),
                          );
                        },
                        type: null,
                        height: 70,
                        width: 300,
                        borderRadius: 30,
                        // isOutline: true,
                        color: Color.fromARGB(255, 62, 112, 82),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              // child: Text(
              //   "انتظرونا قريباً",
              //   style: TextStyle(color: Colors.red[900], fontSize: 30),
              //   textAlign: TextAlign.center,
              // ),
              // ),
               Container(
                padding:
                    const EdgeInsets.only(top: 3.0, left: 20.0, right: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const FoodPostScreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: const Color(0xFF1A4D2E),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 110.0, vertical: 25.0),
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  child: const Text("متبرع  "),
                ),
              ), */
            const SizedBox(
              height: 20.0,
            ),
            /*    ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return const viewAllFood();
                    }),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: const Color(0xFF1A4D2E),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 110.0, vertical: 25.0),
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                child: const Text('مستفيد'),
              )*/
          ]),
        ),
      ),
    );
  }
}
