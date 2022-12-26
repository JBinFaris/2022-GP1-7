import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/widgets/my_awerness_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class myAware extends StatefulWidget {
  const myAware({Key? key}) : super(key: key);

  @override
  _myAwareState createState() => _myAwareState();
}

class _myAwareState extends State<myAware> {
  TextEditingController awarPost = TextEditingController();

  String idddd = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('      محتواي التوعوي ')),
        backgroundColor: const Color(0xFF1A4D2E),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color.fromARGB(225, 255, 255, 255),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.1, 0.9],
                  colors: [Color.fromARGB(142, 26, 77, 46), Color(0xffd6ecd0)]),
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .where('userId', isEqualTo: idddd)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snaphot) {
                if (snaphot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }
                if (snaphot.hasData && snaphot.data?.size == 0) {
                  return const Center(
                      child: Text("! لم تقم بنشر محتوى بعد",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )));
                }

                return ListView.builder(
                  itemCount: snaphot.data?.docs.length,
                  itemBuilder: (context, index) => MyCard(
                    id: snaphot.data?.docs[index].id,
                    snap: snaphot.data?.docs[index].data(),
                    reference: snaphot.data!.docs[index].reference,
                  ),
                );
              },
            )),

        // Add new product

        // backgroundColor:Color.fromARGB(255, 235, 241, 233),
      ),
    );
  }
}
