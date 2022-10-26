import 'package:faydh/SignUp_Form.dart';
import 'package:faydh/awarenessPost.dart';
import 'package:faydh/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'forget-password.dart';

class signInSreen extends StatefulWidget {
  const signInSreen({Key? key}) : super(key: key);

  @override
  State<signInSreen> createState() => _signInSreenState();
}

class _signInSreenState extends State<signInSreen> {
  int _selectedIndex = 1;

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
          vertical: 70,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 120),
              Image.asset(
                'assets/imgs/logo.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 30),
              TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'اسم المستخدم',
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
              TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
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
              const SizedBox(height: 50),
              MaterialButton(
                  elevation: 5.0,
                  color: const Color(0xff1a4d2e),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const Password();
                  }));
                },
                child: const Text('نسيت كلمة المرور؟',
                    style: TextStyle(
                      color: Color(0xff201a19),
                      fontSize: 20,
                    )),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SignupForm();
                  }));
                },
                child: const Text('مستخدم جديد؟ تسجيل',
                    style: TextStyle(
                      color: Color(0xff201a19),
                      fontSize: 20,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
