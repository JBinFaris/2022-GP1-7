import 'dart:io';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/Database/database.dart';
import 'package:faydh/upload_api.dart';
import 'package:faydh/widgets/edit_posts_new.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'ReservedListProvider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class FoodPostScreen extends StatefulWidget {
  const FoodPostScreen({Key? key}) : super(key: key);

  @override
  State<FoodPostScreen> createState() => _FoodPostScreenState();
}

String? selectedValue;

final List<String> myList = [
  "الرياض",
  "جدة",
  "مكة المكرمة",
  "المدينة المنورة",
  "سلطانة",
  "تبوك",
  "الطائف",
  "بريدة",
  " خميس مشيط",
  "الهفوف",
  "المبرز",
  " حفر الباطن",
  "حائل",
  "نجران",
  "الجبيل",
  "أبها",
  "ينبع",
  "الخُبر",
  "عنيزة",
  "عرعر",
  "سكاكا",
  "سكاكا",
  "القريات",
  "الظهران",
  "القطيف",
  "الباحة",
  "تاروت",
  "البيشة",
  "الرس",
  "الشفا",
  "سيهات",
  "المذنب",
  "الخفجي",
  "الدوادمي",
  "صبيا",
  "الزلفي",
  " أبو العريش",
  "الصفوى",
  "رابغ",
  "رحيمة",
  "الطريف",
  "عفيف",
  "طبرجل",
  "الدلم",
  "أملج",
  "العلا",
  "بقيق",
  " بدر حنين",
  "صامطة",
  "الوجه",
  "البكيرية",
  "نماص",
  "السليل",
  "تربة",
  "الجموم",
  "ضباء",
  "الطريف",
  "القيصومة",
  "البطالية",
  "المنيزلة",
  "المجاردة",
  "تنومة",
  "تنومة"
];

class _FoodPostScreenState extends State<FoodPostScreen> {
  bool arrow = false;

  Future<String?> getData() async {
    var a = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final myrole = a['role'];
    if (myrole == "فرد") {
      setState(() {
        arrow = true;
      });
    }
    if (myrole == "منظمة تجارية") {
      getToken(id: FirebaseAuth.instance.currentUser!.uid);
    }
    return null;
  }

  String id = FirebaseAuth.instance.currentUser!.uid;
//heeree
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
        saveToken(id: FirebaseAuth.instance.currentUser!.uid, token: token!);
      });
      saveToken(id: FirebaseAuth.instance.currentUser!.uid, token: token!);
    });
  }

  void saveToken({required String id, required String token}) async {

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    DateTime dt1Now = DateTime.parse(formattedDate);
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

        var send = false;

        if (dt1Now.isAfter(dt2check)) {
          if (doc["sendExpProvider"] == false) {
            FirebaseFirestore.instance
                .collection('foodPost')
                .doc(doc["docId"])
                .update({'sendExpProvider': true});
            Future.delayed(const Duration(seconds: 2), () {
              initInfo();
              sendPushMessage(
                  token: token, title: "طعام منتهي الصلاحية", text: doc["postTitle"]);
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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> foodPostStream = FirebaseFirestore.instance
        .collection('foodPost')
        .where('Cid', isEqualTo: id)
        .where('reserve', isEqualTo: '0')
        .where('providerblocked', isEqualTo: false)
        // .orderBy("docId",descending: true,)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: arrow
          ? AppBar(
              elevation: 2.0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF1A4D2E),
              title: const Text("إعلاناتي      "),
              actions: <Widget>[
                SizedBox(
                    width: 130,
                    height: 130,
                    child: FittedBox(
                      child: FloatingActionButton.extended(
                        heroTag: "btn1",
                        label: const Text(
                          'الطلبات المحجوزة',
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
                              return const ReservedProviderScreen();
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
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF1A4D2E),
              title: const Text('إعلاناتي           '),
              actions: <Widget>[
                SizedBox(
                    width: 130,
                    height: 130,
                    child: FittedBox(
                      child: FloatingActionButton.extended(
                        heroTag: "btn1",
                        label: const Text(
                          'الطلبات المحجوزة',
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
                              return const ReservedProviderScreen();
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
                child: Text("! لم تقم بنشر تبرعات بعد",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )));
          }
          return Directionality(
            textDirection: ui.TextDirection.rtl,
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
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
                            color: const Color.fromARGB(255, 62, 112, 82)
                                .withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
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
                                "  ${data['postTitle'].toString()}",
                                style: const TextStyle(
                                  color: Color(0xFF1A4D2E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, bottom: 8),
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
                                padding: const EdgeInsets.only(
                                    right: 0, bottom: 8, left: 10),
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
                                                    title:
                                                        "${data["postTitle"]}",
                                                    address:
                                                        "${data["postAdress"]}",
                                                    text: "${data["postText"]}",
                                                    count:
                                                        "${data["food_cont"]}",
                                                    expireDate:
                                                        "${data["postExp"]}",
                                                    imgUrl:
                                                        "${data["postImage"]}",
                                                    path:
                                                        "${data["pathImage"]}",
                                                    reference: document
                                                            .reference
                                                        as DocumentReference<
                                                            Map<String,
                                                                dynamic>>,
                                                  )),
                                        );
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15.0))),
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
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15.0))),
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
                                                      child:
                                                          const Text("إلغاء"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text("موافق"),
                                                      onPressed: () async {
                                                        print(document.id
                                                            .toString());

                                                        document.reference
                                                            .delete();

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'reportedContent')
                                                            .where('postId',
                                                                isEqualTo: data[
                                                                    "docId"])
                                                            .get()
                                                            .then((QuerySnapshot
                                                                querySnapshot) {
                                                          querySnapshot.docs
                                                              .forEach((doc) {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'reportedContent')
                                                                .doc(doc["Rid"])
                                                                .delete();
                                                          });
                                                        });

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
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15.0))),
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
                                            color:
                                                Color.fromARGB(255, 172, 8, 8),
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
      ),
    );
  }

  mySheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return const MyStateFullForSheet();
        });
  }
}

class MyStateFullForSheet extends StatefulWidget {
  const MyStateFullForSheet({
    super.key,
  });

  @override
  State<MyStateFullForSheet> createState() => _MyStateFullForSheetState();
}

class _MyStateFullForSheetState extends State<MyStateFullForSheet> {
  File? fileImage;
  UploadTask? taskImage;
  String? urlDownloadImage;

  Future selectFileImage() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (results == null) return;
    final paths = results.files.single.path!;

    setState(() => fileImage = File(paths));

    uploadFileImage();
  }

  Future uploadFileImage() async {
    if (fileImage == null) return;

    final fileNameImage = basename(fileImage!.path);
    final destinations = 'fileImages/$fileNameImage';

    taskImage = FirebaseApi.uploadFile(destinations, fileImage!);
    setState(() {});

    if (taskImage == null) return;

    final snapshot = await taskImage!.whenComplete(() {});
    urlDownloadImage = await snapshot.ref.getDownloadURL();
    setState(() {});

    print('Download-Image-Link: $urlDownloadImage');
  }

  final _formKey = GlobalKey<FormState>();
  String _date = "";
  TextEditingController postTitleTextEditingController =
      TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController foodCountEditingController = TextEditingController();

  TextEditingController addressEditingController = TextEditingController();
  TextEditingController nigbehoodEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    final fileNameImage =
        fileImage != null ? basename(fileImage!.path) : "لم يتم اختيار صورة";

    return Padding(
      padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textAlign: TextAlign.right,
                controller: postTitleTextEditingController,
                decoration: const InputDecoration(
                  hintText: "نوع الطعام ",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A4D2E)),
                  ),
                ),
                maxLength: 60,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length >= 60) {
                    return 'الحد الأقصى للكتابة هو 60 حرف';
                  }

                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                textAlign: TextAlign.right,
                controller: descriptionTextEditingController,
                decoration: const InputDecoration(
                  hintText: "الوصف",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A4D2E)),
                  ),
                ),
                maxLength: 300,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length >= 300) {
                    return 'الحد الأقصى للكتابة هو 300 حرف';
                  }

                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                textAlign: TextAlign.right,
                controller: foodCountEditingController,
                decoration: const InputDecoration(
                  hintText: "كمية الطعام",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A4D2E)),
                  ),
                ),
                maxLength: 20,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length >= 20) {
                    return 'الحد الأقصى للكتابة هو 20 حرف';
                  }

                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: DropdownButtonFormField<String>(
                        alignment: Alignment.centerRight,
                        value: selectedValue,
                        icon: const Align(
                          alignment: Alignment.centerRight,
                        ),
                        elevation: 16,
                        borderRadius: BorderRadius.circular(40),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          label: const Align(
                              alignment: Alignment.centerRight,
                              child: Text('المدينه')),
                        ),
                        items: myList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'الرجاء اختيار المدينة';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value.toString();
                            if (kDebugMode) {
                              print("selectedValue  onChanged:$selectedValue");
                            }
                          });
                        },
                        onSaved: (value) {
                          selectedValue = value.toString();
                          if (kDebugMode) {
                            print("selectedValue  onSaved:$selectedValue");
                          }
                        },
                      ))),
              TextFormField(
                textAlign: TextAlign.right,
                controller: nigbehoodEditingController,
                decoration: const InputDecoration(
                  hintText: "الحي",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A4D2E)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال إسم الحي';
                  }

                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(140, 0, 10, 0),
                child: Row(
                  children: [
                    //  SizedBox(width: 100,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              theme: const DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2050, 12, 31),
                              onConfirm: (date) {
                            var date_with_raw_format =
                                date.toString().split(' ');
                            var finalDate =
                                date_with_raw_format[0].toString().split('-');

                            _date =
                                '${finalDate[0]}-${finalDate[1]}-${finalDate[2]}';
                            print('confirm $date');

                            setState(() {});
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          //height: 50.0,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 69,
                                        child: Text(
                                          " $_date",
                                          style: const TextStyle(
                                              color: Color(0xFF1A4D2E),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(":تاريخ الإنتهاء   ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF1A4D2E),
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const Icon(
                                        Icons.date_range,
                                        size: 18.0,
                                        color: Color(0xFF1A4D2E),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 110),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          selectFileImage();
                        },
                        icon: const Icon(
                          Icons.add_photo_alternate,
                          size: 25,
                        ), //icon data for elevated button
                        label: const Text(
                          "إضافة صورة",
                          textAlign: TextAlign.left,
                        ), //label text
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A4D2E),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              fileImage == null
                  ? Align(
                      alignment: Alignment.center,
                      child: Text(
                        fileNameImage,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 15,
              ),
              fileImage != null
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            fileImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 100,
                        width: 100,
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* const Icon(
    Icons.train,
    color: Colors.black,
    size: 54,
  ),
  style: ElevatedButton.styleFrom(
    shape: CircleBorder(), //<-- SEE HERE
    padding: EdgeInsets.all(20),
  ),*/
                  /*   FloatingActionButton.large(
                    backgroundColor: const Color(0xFF1A4D2E),
                    onPressed: () {
                      selectFileImage();
                    },
                    child: const Icon(Icons.add_photo_alternate),
                  ),*/
                  urlDownloadImage == null
                      ? Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            child: const Text('إضافة الإعلان'),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  title: const Text('تأكيد!'),
                                  content: const Text(
                                      'عند موافقتك لنشر الاعلان لن تتمكن من تعديل أو حذف الإعلان إذا تم حجزه. '),
                                  actions: [
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("إلغاء"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            print("dataurl: $urlDownloadImage");
                                            print(
                                                "useris:: ${user!.displayName}");
                                            if (_date != "" &&
                                                _formKey.currentState!
                                                    .validate() &&
                                                urlDownloadImage != null) {
                                              if (kDebugMode) {
                                                print(
                                                    "selectedValue on final:$selectedValue");
                                              }

                                              Database.addFoodPostData(
                                                context: context,
                                                docId:
                                                    DateTime.now().toString(),
                                                userUid: user.uid.toString(),
                                                userPost:
                                                    user.displayName.toString(),
                                                postTitle:
                                                    postTitleTextEditingController
                                                        .text
                                                        .toString(),
                                                postText:
                                                    descriptionTextEditingController
                                                        .text
                                                        .toString(),
                                                postAdress: selectedValue
                                                        .toString() +
                                                    ", " +
                                                    nigbehoodEditingController
                                                        .text
                                                        .toString(),
                                                postImage:
                                                    urlDownloadImage.toString(),
                                                postExp: _date.toString(),
                                                food_cont:
                                                    foodCountEditingController
                                                        .text
                                                        .toString(),
                                                providerblocked: false,
                                                reserve: '0',
                                                notify: '0',
                                                notifyCancelP: '1',
                                                notifyCancelC: '1',
                                                sendExpProvider: false,
                                                sendExpConsumer: false,
                                              ).whenComplete(() {
                                                Navigator.pop(context);
                                                setState(() {
                                                  selectedValue = null;
                                                });
                                              });

                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                "postCount":
                                                    FieldValue.increment(1)
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: "الرجاء تعبئة كافة الحقول",
                                                backgroundColor: Colors.red,
                                              );
                                            }
                                          },
                                          child: const Text("موافق"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A4D2E),
                            ),
                            child: const Text(' إضافة الإعلان'),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
