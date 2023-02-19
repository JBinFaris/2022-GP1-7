import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/ApproveBusiness.dart';
import 'package:faydh/reportedContent.dart';
import 'package:faydh/reports.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:faydh/usersListCards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:faydh/components/background.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});
  @override
  State<AdminMain> createState() => _AdminMainPageState();
}

@override
class _AdminMainPageState extends State<AdminMain> {
  String? mtoken = "";

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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

  void saveToken({required String id, required String token}) async {
    /* await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'token': token});}*/

    FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'منظمة تجارية')
        .where('status', isEqualTo: '0')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (true) {
          Future.delayed(const Duration(seconds: 2), () {
            print("expired");
            initInfo();
            sendPushMessage(
                token: token,
                title: "منظمة تجارية تحتاج للتحقق",
                text: doc["username"]);
          });
        } //end if
      });
    });
  }

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

  @override
  initState() {
    super.initState();

    getToken(id: FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

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
              ])),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
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
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        backgroundColor: const Color.fromARGB(255, 18, 57, 20),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ApproveBusiness()));
                      },
                      child: const Text(
                        "التحقق من الشركات",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        backgroundColor: const Color.fromARGB(255, 18, 57, 20),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const reportsScreen()));
                      },
                      child: const Text(
                        "البلاغات",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        backgroundColor: const Color.fromARGB(255, 18, 57, 20),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UsersListCards()));
                      },
                      child: const Text(
                        "قائمة المستخدمين",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        backgroundColor: const Color.fromARGB(255, 172, 8, 8),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  title: const Text(
                                    'تسجيل الخروج',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: const Text(
                                    "هل ترغب بتسجيل الخروج ؟ ",
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
                                        AuthMethods().signOut().then((value) {
                                          if (value == "success") {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const signInSreen();
                                            }));
                                          }
                                        });
                                      },
                                    ),
                                  ]);
                            });
                      },
                      child: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
