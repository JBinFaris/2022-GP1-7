import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/myAwareness.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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

  @override
  void initState() {
    super.initState();
    _getUserData();
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
        //   myrole = (snap.data() as Map<String, dynamic>)['role'];
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
                            height: 30,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const myAware();
                              }));
                            },
                            label: const Text('محتواي التوعوي'),
                            icon: const Icon(Icons.arrow_back_ios_new),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: const Color(0xFF1A4D2E),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 90.0, vertical: 15.0),
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),

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
                          height: 7.0,
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
