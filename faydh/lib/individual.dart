import 'package:faydh/FoodPost.dart';
import 'package:faydh/viewAllFood.dart';
import 'package:flutter/material.dart';
import 'package:faydh/components/background.dart';

class individual extends StatefulWidget {
  const individual({super.key});
  @override
  State<individual> createState() => _individualPageState();
}

@override
class _individualPageState extends State<individual> {
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
