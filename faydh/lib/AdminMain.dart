import 'package:faydh/ApproveBusiness.dart';
import 'package:faydh/reportedContent.dart';
import 'package:faydh/reports.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:flutter/material.dart';
import 'package:faydh/components/background.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});
  @override
  State<AdminMain> createState() => _AdminMainPageState();
}

@override
class _AdminMainPageState extends State<AdminMain> {
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
          padding: const EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
          child: Expanded(
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
                      width: 250,
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          backgroundColor:
                              const Color.fromARGB(255, 18, 57, 20),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ApproveBusiness()));
                        },
                        child: const Text(
                          "التحقق من الشركات",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 30,
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
                          backgroundColor:
                              const Color.fromARGB(255, 18, 57, 20),
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
                              fontSize: 20),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 30,
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
                          backgroundColor: const Color.fromARGB(255, 172, 8, 8),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
      ),
    );
  }
}
