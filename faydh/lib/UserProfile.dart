import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/myAwareness.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:button_animations/button_animations.dart';

import 'models/bar_chatmodel.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? Key}) : super(key: Key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userName = "";
  String userEmail = "";
  String phoneNumber = "";
  String myrole = "";
  String myCr = "";
  String myStatus = "";
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future getuserpostandotherdata(rewrite) async {
    var postCount = 0, reserveCount = 0, ExpCount = 0;
    var date = DateTime.now();
    var expdate;
    DateTime exp;
    var posted = await FirebaseFirestore.instance
        .collection("foodPost")
        .where('Cid', isEqualTo: '${FirebaseAuth.instance.currentUser!.uid}')
        .get();
    posted.docs.forEach((element) {
      expdate = element.data()['postExp'].toString().split('-');
      exp = DateTime(
        int.parse(expdate[0]),
        int.parse(expdate[1]),
        int.parse(expdate[2]),
      );
      if (element.data()['reserve'] == '1') {
        reserveCount = reserveCount + 1;
      }
      if (exp.isBefore(DateTime.now().subtract(const Duration(days: 1))) ==
          true) {
        ExpCount = ExpCount + 1;
      }
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'postCount': '${posted.docs.length}',
      'reserveCount': '$reserveCount',
      'ExpCount': '$ExpCount'
    });

    return {
      'post posted': posted.docs.length,
      'posts with expiry date': '$ExpCount',
      'postesreserved': '$reserveCount'
    };
  }

  fetchUserData() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return snap.data();
  }

  void _getUserData() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      if (snap != null) {
        userName = (snap.data() as Map<String, dynamic>)['username'];

        userEmail = (snap.data() as Map<String, dynamic>)['email'];
        phoneNumber = (snap.data() as Map<String, dynamic>)['phoneNumber'];
        myrole = (snap.data() as Map<String, dynamic>)['role'];
        {
          if (myrole == "منظمة تجارية") {
            myCr = (snap.data() as Map<String, dynamic>)['crNo'];
            myStatus = (snap.data() as Map<String, dynamic>)['status'];
          }

          //  Map myReg = (snap.data() ?? {}) as Map;
        }
      }
    });
  }

  @override
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _email =
        TextEditingController.fromValue(TextEditingValue(text: userEmail));
    TextEditingController _username =
        TextEditingController.fromValue(TextEditingValue(text: userName));
    TextEditingController _phone =
        TextEditingController.fromValue(TextEditingValue(text: phoneNumber));
    TextEditingController _role =
        TextEditingController.fromValue(TextEditingValue(text: myrole));
    TextEditingController _crNo =
        TextEditingController.fromValue(TextEditingValue(text: myCr));
    //var _formkey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 90.0),
          child: Stack(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 80.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [
                        0.1,
                        0.9
                      ],
                      colors: [
                        Color.fromARGB(142, 26, 77, 46),
                        Color(0xffd6ecd0)
                      ]),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 105.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          // Text("الملف الشخصي",
                          //  style: TextStyle(
                          //    fontSize: 30.0,
                          //    height: 2.0,
                          //  )),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 4),
                            child: TextFormField(
                              controller: _email,
                              enabled: false,
                              //field value
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email,
                                  size: 30,
                                  color: Color.fromARGB(255, 18, 57, 20),
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 18, 57, 20)),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                label: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('البريد الإلكتروني'),
                                ),

                                // contentPadding: EdgeInsets.only(left:230),
                                fillColor: Colors.white70,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //username
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 4),
                            child: TextFormField(
                              controller: _username, //field value
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.account_circle_rounded,
                                  size: 30,
                                  color: Color.fromARGB(255, 18, 57, 20),
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 18, 57, 20)),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                label: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('اسم المستخدم'),
                                ),

                                // contentPadding: EdgeInsets.only(left:230),
                                fillColor: Colors.white70,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال إسم المستخدم';
                                } else if (value.length < 3) {
                                  return 'إسم المستخدم يجب ان يكون اكثر من ٣ رموز';
                                } else if (value.length > 15) {
                                  return 'لا يمكن لإسم المستخدم ان يكون اكثر من ١٥ رموز';
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //password

                          //phone number
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 4),
                            child: TextFormField(
                              controller: _phone,
                              //field value
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone_rounded,
                                  size: 30,
                                  color: Color.fromARGB(255, 18, 57, 20),
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 18, 57, 20)),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                label: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('رقم الجوال'),
                                ),

                                // contentPadding: EdgeInsets.only(left:230),
                                fillColor: Colors.white70,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال رقم الجوال';
                                } else if (value.length != 10) {
                                  return 'رقم الجوال يجب ان يكون مكون من ١٠ رموز';
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //Commercial registration
                          if (myrole == "منظمة تجارية" && myStatus == "0")
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 4),
                              child: TextFormField(
                                controller: _crNo, //field value
                                enabled: false,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.hourglass_top_rounded,
                                    size: 30,
                                    // color: Color.fromARGB(255, 18, 57, 20),
                                    color: Color.fromARGB(255, 249, 176, 4),
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 18, 57, 20)),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  label: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('رقم السجل التجاري'),
                                  ),

                                  // contentPadding: EdgeInsets.only(left:230),
                                  fillColor: Colors.white70,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال رقم السجل التجاري';
                                  } else if (value.length != 10) {
                                    return 'رقم السجل التجاري يجب ان يكون مكون من ١٠ رموز';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          if (myrole == "منظمة تجارية" && myStatus == "1")
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 4),
                              child: TextFormField(
                                controller: _crNo, //field value
                                enabled: false,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.check,
                                    size: 30,
                                    //color: Color.fromARGB(255, 18, 57, 20),
                                    color: Color.fromARGB(255, 16, 205, 63),
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 18, 57, 20)),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  label: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('رقم السجل التجاري'),
                                  ),

                                  // contentPadding: EdgeInsets.only(left:230),
                                  fillColor: Colors.white70,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال رقم السجل التجاري';
                                  } else if (value.length != 10) {
                                    return 'رقم السجل التجاري يجب ان يكون مكون من ١٠ رموز';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          if (myrole == "منظمة تجارية" && myStatus == "2")
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 4),
                              child: TextFormField(
                                controller: _crNo, //field value
                                enabled: false,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.close,
                                    size: 30,
                                    // color: Color.fromARGB(255, 18, 57, 20),
                                    color: Color.fromARGB(255, 223, 67, 20),
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 18, 57, 20)),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  label: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('رقم السجل التجاري'),
                                  ),

                                  // contentPadding: EdgeInsets.only(left:230),
                                  fillColor: Colors.white70,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال رقم السجل التجاري';
                                  } else if (value.length != 10) {
                                    return 'رقم السجل التجاري يجب ان يكون مكون من ١٠ رموز';
                                  }

                                  return null;
                                },
                              ),
                            ),

                          Container(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                      width: 250,
                                      height: 60,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          backgroundColor: const Color.fromARGB(
                                              255, 18, 57, 20),
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const myAware();
                                          }));
                                        },
                                        child: const Text(
                                          "محتواي التوعوي",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 20),
                                        ),
                                      )),
                                ),
                                /* Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: AnimatedButton(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        //  Icon(Icons.person, color: Colors.white),
                                        Text("محتواي التوعوي",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return const myAware();
                                      }));
                                    },
                                    type: null,
                                    height: 60,
                                    width: 260,
                                    borderRadius: 30,
                                    color: Color.fromARGB(255, 62, 112, 82),
                                  ),
                                ), */
                                //here
                                const SizedBox(
                                  height: 15,
                                ),
                                FutureBuilder(
                                    future: fetchUserData(),
                                    builder:
                                        (context, AsyncSnapshot userdatasnap) {
                                      if (userdatasnap.hasData) {
                                        log(userdatasnap.data['role']
                                            .toString());

                                        //if the user is not charity then this will show the button
                                        if (userdatasnap.data['role']
                                                .toString() !=
                                            'منظمة خيرية') {
                                          return SizedBox(
                                            width: 250,
                                            height: 60,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) => Container(
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      10,
                                                                  vertical: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      3.3),
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                50),
                                                                    height: double
                                                                        .maxFinite,
                                                                    width: double
                                                                        .maxFinite,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFFf7f7f7),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: FutureBuilder(
                                                                        future: getuserpostandotherdata(userdatasnap.data),
                                                                        builder: (context, datasnap) {
                                                                          if (datasnap.connectionState == ConnectionState.done &&
                                                                              datasnap.hasData) {
                                                                            _createSampleData() {
                                                                              return SfCartesianChart(
                                                                                palette: [
                                                                                  Color.fromRGBO(205, 233, 197, 1),
                                                                                ],
                                                                                plotAreaBorderWidth: 0,
                                                                                title: ChartTitle(
                                                                                  text: ' ',
                                                                                ),
                                                                                primaryXAxis: CategoryAxis(
                                                                                  majorGridLines: const MajorGridLines(width: 0),
                                                                                ),
                                                                                primaryYAxis: NumericAxis(axisLine: const AxisLine(width: 0), labelFormat: '{value}', majorTickLines: const MajorTickLines(size: 0)),
                                                                                series: <ColumnSeries<BarMmodel, String>>[
                                                                                  ColumnSeries<BarMmodel, String>(
                                                                                    dataSource: <BarMmodel>[
                                                                                      BarMmodel('عدد الإعلانات', int.parse('${datasnap.data['post posted']}')),
                                                                                      BarMmodel("الإعلانات المحجوزة", int.parse('${datasnap.data['posts with expiry date']}')),
                                                                                      BarMmodel("الأطعمة منتهية\n الصلاحية", int.parse('${datasnap.data['postesreserved']}')),
                                                                                    ],
                                                                                    xValueMapper: (BarMmodel sales, _) => sales.x as String,
                                                                                    yValueMapper: (BarMmodel sales, _) => sales.y,
                                                                                    dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 10)),
                                                                                  )
                                                                                ],
                                                                              );
                                                                            }

                                                                            log(datasnap.data.toString());
                                                                            return Padding(
                                                                                padding: const EdgeInsets.only(top: 40, bottom: 20),
                                                                                child: _createSampleData());
                                                                          } else {
                                                                            return CupertinoActivityIndicator();
                                                                          }
                                                                        }),
                                                                  ),
                                                                  const Positioned(
                                                                      right: 0,
                                                                      left: 0,
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            Color(0xFFd6ecd0),
                                                                        radius:
                                                                            40,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .query_stats_outlined,
                                                                          size:
                                                                              55,
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 10.0, 20.0, 10.0),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 18, 57, 20),
                                                shape: const StadiumBorder(),
                                              ),
                                              child: const Text(
                                                "إحصائياتي",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 20),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ],
                            ),
                          ),
                          /* ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const myAware();
                              }));
                            },
                            child: const Text('محتواي التوعوي'),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: const Color(0xFF1A4D2E),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0, vertical: 15.0),
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ), */

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: const Text(
                                                'تسجيل الخروج',
                                                textAlign: TextAlign.right,
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
                                                    AuthMethods()
                                                        .signOut()
                                                        .then((value) {
                                                      if (value == "success") {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return const signInSreen();
                                                        }));
                                                      }
                                                    });
                                                  },
                                                ),
                                              ]);
                                        });
                                  },
                                  child: const Text('تسجيل الخروج'),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor:
                                          const Color.fromARGB(255, 172, 8, 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Text(
                                                  'حفظ التغييرات',
                                                  textAlign: TextAlign.right,
                                                ),
                                                content: const Text(
                                                  "هل أنت متأكد من حفظ التغييرات  ؟ ",
                                                  textAlign: TextAlign.right,
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text("إلغاء"),
                                                    onPressed: () {
                                                      // callback function for on click event of Cancel button
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text("موافق"),
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        AuthMethods()
                                                            .upDateProfile(
                                                          role: _role.text,
                                                          username:
                                                              _username.text,
                                                          phoneNumber:
                                                              _phone.text,
                                                        )
                                                            .then((value) {
                                                          if (value ==
                                                              "success") {
                                                            setState(() {
                                                              _getUserData();
                                                              userName;
                                                              userEmail;

                                                              phoneNumber;
                                                              myrole;
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          }
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ]);
                                          });
                                    }
                                  },
                                  child: const Text(' حفظ التغييرات'),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor:
                                          const Color.fromARGB(255, 172, 8, 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/imgs/Faydh2.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text("الملف الشخصي",
                        style: TextStyle(
                          fontSize: 30.0,
                          height: 9.0,
                        )),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  OutlineInputBorder myInputBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(226, 29, 92, 76),
          width: 3,
        ));
  }

  OutlineInputBorder myFocusBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color(0xff1A4D2E),
          width: 3,
        ));
  }
}
