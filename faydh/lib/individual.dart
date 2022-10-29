import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.9],
              colors: [Color.fromARGB(142, 26, 77, 46), Color(0xffd6ecd0)]),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
        child: Expanded(
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
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('مستهلك'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Color(0xFF1A4D2E),
                    padding:
                        EdgeInsets.symmetric(horizontal: 110.0, vertical: 25.0),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('مستفيد'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Color(0xFF1A4D2E),
                  padding:
                      EdgeInsets.symmetric(horizontal: 110.0, vertical: 25.0),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            )
          ]),
        ),
      ),
    );
  }
}
