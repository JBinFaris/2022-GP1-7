import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/AdminMain.dart';
import 'package:faydh/businessHome.dart';
import 'package:faydh/charityHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:faydh/SignUp_Form.dart';
import 'package:faydh/home_page.dart';
import 'package:faydh/utilis/utilis.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'forget-password.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class signInSreen extends StatefulWidget {
  const signInSreen({Key? key}) : super(key: key);

  @override
  State<signInSreen> createState() => _signInSreenState();
}

class _signInSreenState extends State<signInSreen> {
  bool _isObscure = true;
  String? mtoken = "";

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //requestPermission();
    // getToken();
  }

  /* void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('get permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('get provisional permission');
    } else {
      print('decline');
    }
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
      querySnapshot.docs.forEach((doc) {
        var raw_date = doc["postExp"].toString().split('-');
        DateTime dt2check = DateTime(int.parse('${raw_date[0]}'),
            int.parse('${raw_date[1]}'), int.parse('${raw_date[2]}'));
        String exp = doc["postExp"];

        print(exp);
        if (dt1Now.isAfter(dt2check)) {
          Future.delayed(const Duration(seconds: 2), () {
            print("expired");
            initInfo();
            sendPushMessage(
                token: token, title: "طعام منتهي", text: doc["postTitle"]);
            if (doc["expFlag"] != 2) {
              FirebaseFirestore.instance
                  .collection('foodPost')
                  .doc(doc["docId"])
                  .update({"expFlag": FieldValue.increment(1)});
              print(doc["expFlag"] == 3);
            } else if (doc["expFlag"] == 2) {
              print('providerrrrrrrr');
              FirebaseFirestore.instance
                  .collection('foodPost')
                  .doc(doc["docId"])
                  .delete();
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(doc["Cid"])
                  .update({"ExpCount": FieldValue.increment(1)});
            }
          });
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
      querySnapshot.docs.forEach((doc) {
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
          Future.delayed(const Duration(seconds: 2), () {
            print("expired");
            initInfo();
            sendPushMessage(
                token: token, title: "طعام منتهي", text: doc["postTitle"]);
            if (doc["expFlag"] != 2) {
              FirebaseFirestore.instance
                  .collection('foodPost')
                  .doc(doc["docId"])
                  .update({"expFlag": FieldValue.increment(1)});
              print(doc["expFlag"] == 3);
              print(doc["expFlag"]);
            } else if (doc["expFlag"] == 2) {
              print('consumerrrrrrrr');
              FirebaseFirestore.instance
                  .collection('foodPost')
                  .doc(doc["docId"])
                  .delete();
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(doc["Cid"])
                  .update({"ExpCount": FieldValue.increment(1)});
            }
          });
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
  }*/

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  final _formKey = GlobalKey<FormState>();

  void _loginUser({
    required String email,
    required String password,
  }) async {
    String res = "حصل خطأ ما";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        final CUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (CUser != null) {
          res = "success";

          final User? user = await _auth.currentUser;
          final userID = FirebaseAuth.instance.currentUser!.uid;


          DocumentSnapshot snap;
          DocumentSnapshot snap2;

          snap = await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();

          if (snap != null) {
            final myrole = (snap.data() as Map<String, dynamic>)['role'];
            final uid = (snap.data() as Map<String, dynamic>)['uid'];
            final Active = (snap.data() as Map<String, dynamic>)['Active'];

            DateTime dt4check = DateTime.now();
            ;
            DateTime dt3Now = DateTime.now();
            ;
            if (myrole == "منظمة تجارية") {
              final crExpDate = snap["crNoExpDate"];

              DateTime now = DateTime.now();
              String formattedDate = DateFormat('yyyy-MM-dd').format(now);
              dt3Now = DateTime.parse(formattedDate);


              var raw_date = snap["crNoExpDate"].toString().split('-');
              dt4check = DateTime(int.parse('${raw_date[0]}'),
                  int.parse('${raw_date[1]}'), int.parse('${raw_date[2]}'));

            }

            if (Active == true) {
              if (myrole == "فرد") {
                // getToken(id: FirebaseAuth.instance.currentUser!.uid);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              } else if (myrole == "منظمة تجارية") {
                // getToken(id: FirebaseAuth.instance.currentUser!.uid);
                final status = (snap.data() as Map<String, dynamic>)['status'];
                if (status == "0") {
                  res = " بإنتظار الموافقه ";

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            title: const Text(
                              "معلق " + ":" + " حالة الحساب",
                              textAlign: TextAlign.right,
                            ),
                            content: const Text(
                              "الحساب معلق، بإنتظار موافقة المشرف على السجل التجاري\n يرجى معاودة تسجيل الدخول لاحقاً",
                              textAlign: TextAlign.right,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("موافق"),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ]);
                      });
                } else if (status == "2") {
                  res = "  مرفوض";
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            title: const Text(
                              " حالة الحساب" + ": " + " مرفوض ",
                              textAlign: TextAlign.right,
                            ),
                            content: const Text(
                              " الحساب مرفوض نظراً لعدم صحة السجل التجاري" +
                                  "\n" +
                                  "يكنك التواصل مع فريق فيض عبر البريد الالكتروني لتقديم اي شكوى " +
                                  "\n" +
                                  "teamfaydh@gmail.com",
                              textAlign: TextAlign.right,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("موافق"),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ]);
                      });
                } else if (status == "1") {
                  // if (dt3Now.isAfter(dt4check)) {
                  //   res = "موقوف";

                  //   showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return AlertDialog(
                  //             shape: const RoundedRectangleBorder(
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(15.0))),
                  //             title: const Text(
                  //               " حالة الحساب" +
                  //                   ": " +
                  //                   " منتهي تاريخ صالحية السجل التجاري ",
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             content: const Text(
                  //               " الحساب موقوف نظراً لإنتهاء صلاحية السجل التجاري" +
                  //                   "\n" +
                  //                   " يكنك التواصل مع فريق فيض عبر البريد الالكتروني لتقديم شكوى او تجديد السجل التجاري " +
                  //                   "\n" +
                  //                   "teamfaydh@gmail.com",
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             actions: <Widget>[
                  //               TextButton(
                  //                 child: const Text("موافق"),
                  //                 onPressed: () async {
                  //                   Navigator.pop(context);
                  //                 },
                  //               ),
                  //             ]);
                  //       });
                  // } else {
                   Navigator.push(
                       context,
                        MaterialPageRoute(
                           builder: (context) => const businessHome()));
                   }
            //    }
              } else if (myrole == "منظمة خيرية") {
                // getToken(id: FirebaseAuth.instance.currentUser!.uid);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const charityHome()));
              } else if (myrole == "Admin") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AdminMain()));
              }
            } else if (Active == false) {
              res = "  محظور";

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text(
                          " حالة الحساب" + ": " + " محظور ",
                          textAlign: TextAlign.right,
                        ),
                        content: const Text(
                          " الحساب محظور نظراً لعدة من البلاغات " +
                              "\n" +
                              "يكنك التواصل مع فريق فيض عبر البريد الالكتروني لتقديم اي شكوى " +
                              "\n" +
                              "teamfaydh@gmail.com",
                          textAlign: TextAlign.right,
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("موافق"),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ]);
                  });
            }
          } /* else{  print("object");
                snap2 = await FirebaseFirestore.instance
                 .collection("Admins")
                 .doc(userID)
                 .get();
               
               

              if(snap2 != null){
                final  UN = (snap2.data() as Map<String, dynamic>)['username'];
                if(UN == "Admin"){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminMain()));
               }else if(UN == null){ print("object4444");}
               }

               
              }*/
        }
      } else {
        res = "الرجاء إدخال كل الحقول";
        showSnackBar(res, context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = " البريد الإلكتروني او كلمة المرور خاطئة";
      } else if (e.code == "wrong-password") {
        res = "  البريد الإلكتروني او كلمة المرور خاطئة";
      } else {
        res = "حصل خطأ ما";
      }
    } catch (error) {
      res = error.toString();
    }
    showSnackBar(res, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.9],
              colors: [Color.fromARGB(142, 26, 77, 46), Color(0xffd6ecd0)]),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 165,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/imgs/logo.png',
                  width: 250,
                  height: 175,
                ),
                const SizedBox(height: 0.1),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd6ecd0),
                        width: 1.0,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd6ecd0),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd6ecd0),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  obscureText: _isObscure,
                  controller: _passwordController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    prefix: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    hintText: 'كلمة المرور',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd6ecd0),
                        width: 1.0,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd6ecd0),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd6ecd0),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                MaterialButton(
                    elevation: 5.0,
                    color: const Color(0xff1a4d2e),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 80),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _loginUser(
                            email: _emailController.text,
                            password: _passwordController.text);

                        /* AuthMethods()
                            .loginUser(
                                email: _emailController.text,
                                password: _passwordController.text)
                            .then((value) {
                          showSnackBar(value, context);
                          if (value == "success") {


                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage())
                            );
                          }
                        });*/
                      }
                    }),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const PasswordReset();
                    }));
                  },
                  child: const Text('نسيت كلمة المرور؟',
                      style: TextStyle(
                        color: Color(0xff201a19),
                        fontSize: 20,
                      )),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SignupForm();
                    }));
                  },
                  child: const Text('مستخدم جديد؟ تسجيل',
                      style: TextStyle(
                        color: Color.fromARGB(255, 245, 242, 241),
                        fontSize: 20,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
