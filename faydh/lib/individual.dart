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
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "انتظرونا قريباً",
                style: TextStyle(color: Colors.red[900], fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 3.0, left: 20.0, right: 20.0),
              child: ElevatedButton(
                onPressed: () {},
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
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: const Color(0xFF1A4D2E),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 110.0, vertical: 25.0),
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              child: const Text('مستفيد'),
            )
          ]),
        ),
      ),
    );
  }
}
