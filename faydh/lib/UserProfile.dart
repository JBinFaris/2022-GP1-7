import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? Key}) : super(key: Key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  TextEditingController email = TextEditingController();
  static TextEditingController username = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController phone = TextEditingController();
  Widget build(BuildContext context) {
    var _formkey = GlobalKey<FormState>();
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
                    key: _formkey,
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
                                  onPressed: () {},
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
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      'images/Faydh.png',
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text("الملف الشخصي",
                      style: TextStyle(
                        fontSize: 30.0,
                        height: 7.0,
                      )),
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
          child: Image.asset('images/Faydh.png'),

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
}
