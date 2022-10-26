import 'package:flutter/material.dart';

class individual extends StatelessWidget {
  const individual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.9],
              colors: [Color.fromARGB(142, 26, 77, 46), Color(0xffd6ecd0)]),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: ClipOval(
              child: Image.asset(
                'assets/imgs/logo.png',
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 140.0, left: 20.0, right: 20.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('مستهلك'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Color.fromARGB(226, 29, 92, 76),
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
                primary: Color.fromARGB(226, 29, 92, 76),
                padding:
                    EdgeInsets.symmetric(horizontal: 110.0, vertical: 25.0),
                textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color(0xFF1A4D2E),
        iconSize: 35,
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
          child: Image.asset('assets/imgs/logo.png'),

          // backgroundColor:Color.fromARGB(255, 235, 241, 233),

          backgroundColor: Colors.white),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
