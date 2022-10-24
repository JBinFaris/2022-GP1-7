
import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';

import 'dbHelper/mongodb.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? Key}) : super(key: Key);

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String id = '63546c58f3dfa274b6ea029c';
  @override
  void initState() {
    Future.microtask(() {
      getData();
    });
    super.initState();
  }

  Future<void> getData() async {
    Map<String, dynamic>? data = await MongoDatabase.getUserData(id);
    if (data != null) {
      email.text = data['email'] ?? '';
      username.text = data['username'] ?? '';
      password.text = data['password'] ?? '';
      phone.text = data['phone'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    //var _formkey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Color(0xffE5F0DA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Container(
                      padding:
                          EdgeInsets.only(top: 105.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          // Text("الملف الشخصي",
                          //  style: TextStyle(
                          //    fontSize: 30.0,
                          //    height: 2.0,
                          //  )),

                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال البربد الإلكتروني';
                                } else if (!value.contains("@") ||
                                    !value.contains(".")) {
                                  return 'الرجاء إدخال بريد إلكتروني صالح';
                                }
                                return null;
                              },
                              controller: email,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: 'البريدالالكتروني',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                border: myInputBorder(),
                                enabledBorder: myInputBorder(),
                                focusedBorder: myFocusBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),

                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال إسم المستخدم';
                                } else if (value.length < 3) {
                                  return 'إسم المستخدم يجب ان يكون اكثر من ٣ رموز';
                                } else if (value.length > 8) {
                                  return 'لا يمكن لإسم المستخدم ان يكون اكثر من ٨ رموز';
                                }

                                return null;
                              },
                              controller: username,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: 'اسم المستخدم',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                border: myInputBorder(),
                                enabledBorder: myInputBorder(),
                                focusedBorder: myFocusBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال كلمة المرور';
                                } else if (value.length < 8) {
                                  return 'كلمة المرور يجب ان تكون اكثر من ٨ رموز';
                                } else if (value.length > 15) {
                                  return 'لا يمكن لكلمة المرور ان تكون اكثر من ١٥ رمز';
                                }

                                return null;
                              },
                              controller: password,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: 'كلمة المرور',
                                prefixIcon: Icon(
                                  Icons.lock_clock_outlined,
                                  color: Colors.grey,
                                ),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                border: myInputBorder(),
                                enabledBorder: myInputBorder(),
                                focusedBorder: myFocusBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال رقم الجوال';
                                } else if (value.length != 10) {
                                  return 'رقم الجوال يجب ان يكون مكون من ١٠ رموز';
                                }

                                return null;
                              },
                              controller: phone,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: 'رقم الهاتف',
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                border: myInputBorder(),
                                enabledBorder: myInputBorder(),
                                focusedBorder: myFocusBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: Text('محتواي التوعوي'),
                            icon: Icon(Icons.arrow_back_ios_new),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                primary: Color.fromARGB(226, 29, 92, 76),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 90.0, vertical: 15.0),
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('تسجيل الخروج'),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      primary: Color.fromARGB(255, 172, 8, 8),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      Map<String, dynamic> data =
                                          await MongoDatabase.updateUserData(
                                              id, {
                                        'email': email.text.trim(),
                                        'password': password.text.trim(),
                                        'username': username.text.trim(),
                                        'phone': phone.text.trim(),
                                      });
                                      final snackBar = SnackBar(
                                          content: Text(data['message']));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: Text(' حفظ التغييرات'),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      primary: Color.fromARGB(255, 172, 8, 8),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      textStyle: TextStyle(
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
            //SafeArea(
            // child: FutureBuilder(
            //   future: MongoDatabase.getqueryname(),
            // builder: (context, AsyncSnapshot snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            // return Center(
            // child: CircularProgressIndicator(),
            //);
            //} else {
            //if (snapshot.hasData) {
            // return Center(
            //  child: Text("gggggggggggggggggggg"),
            //   );
            // } else {
            //   return Center(
            //    child: Text("Data Not Found"),
            // );
            // }
            // }
            // }),
            // ),
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
                  Center(
                    child: Text("الملف الشخصي",
                        style: TextStyle(
                          fontSize: 30.0,
                          height: 7.0,
                        )),
                  ),
                  //edit button
                  // Positioned(
                  // bottom: 120,
                  // right: 25,
                  // child: Container(
                  // padding: EdgeInsets.all(5.0),
                  //decoration: BoxDecoration(
                  //   color: Colors.greenAccent, shape: BoxShape.circle),
                  // child: Icon(
                  // Icons.edit,
                  // size: 30.0,
                  //)
                  //),
                  //)
                ],
              ),
            ),
          ]),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromARGB(226, 29, 92, 76),
        selectedItemColor: Color.fromARGB(226, 29, 92, 76),
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_rounded),
            label: 'المنتدى التوعوي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'الملف الشخصي',
          ),
        ],
        //  currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        // onTap: _onItemTapped,
      ),
      // Add new product

      floatingActionButton: FloatingActionButton.large(
          onPressed: () {},
          child: Image.asset('assets/imgs/Faydh2.png'),

          // backgroundColor:Color.fromARGB(255, 235, 241, 233),

          backgroundColor: Colors.white),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  OutlineInputBorder myInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(226, 29, 92, 76),
          width: 3,
        ));
  }

  OutlineInputBorder myFocusBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color(0xff1A4D2E),
          width: 3,
        ));
  }

  Future<void> _insertData(
      String email, String username, String phone, String password) async {
    var id = M.ObjectId();
    final data = {
      "_id": id,
      "username": username,
      "email": email,
      "phone": phone,
      "password": password
    };

    ScaffoldMessenger.of(context)
        // ignore: prefer_interpolation_to_compose_strings
        .showSnackBar(SnackBar(content: Text("inserted ID" + id.$oid)));
  }
}

