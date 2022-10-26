import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'MongoDBModel.dart';
import 'dbHelper/mongodb.dart';

class myAware extends StatefulWidget {
  myAware({Key? key}) : super(key: key);
  @override
  _myAwareState createState() => _myAwareState();
}

class _myAwareState extends State<myAware> {
  @override
  TextEditingController awarPost = TextEditingController();
  //bool _isEnable = false;
  String id = '6358fc8e8e5eae4234fa51bf';
  // void initState() {
  // Future.microtask(() {
  //   MongoDatabase.Get();
  // });
  // super.initState();
  //}

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: MongoDatabase.Get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return displayData(
                            MongoDbModel.fromJson(snapshot.data[index]));
                        //mongodb.Get()
                      },
                    );
                  } else {
                    return Center(child: Text("data not found"));
                  }
                }
              })),
      backgroundColor: Color.fromARGB(225, 30, 122, 99),
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

  Widget displayData(MongoDbModel data) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: TextEditingController(
                    text: "${data.content}",
                  ),
                  //enabled: _isEnable,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(300),
                  ],
                  //keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          //setState(() {
                          //  _isEnable = true;
                          //});
                        },
                        child: Text('تحرير'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: Color.fromARGB(255, 172, 8, 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 3.0),
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          //controller:
                          //awarPost.text;
                          Map<String, dynamic> data =
                              await MongoDatabase.updateAwar(id, {
                            'content': awarPost.text,
                          });
                          final snackBar =
                              SnackBar(content: Text(data['message']));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text('حذف'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: Color.fromARGB(255, 172, 8, 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 3.0),
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //child: Row(children: const [],),
        ));
  }
}
