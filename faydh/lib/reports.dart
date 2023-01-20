import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/reportedContent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faydh/widgets/ConsumerListCard.dart';

class reportsScreen extends StatefulWidget {
  const reportsScreen({Key? key}) : super(key: key);

  @override
  State<reportsScreen> createState() => _reportsScreenState();
}

String id = FirebaseAuth.instance.currentUser!.uid;

class _reportsScreenState extends State<reportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffd6ecd0),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text('      البلاغات')),
          backgroundColor: const Color.fromARGB(151, 26, 77, 46),
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
                  stops: [
                    0.1,
                    0.9
                  ],
                  colors: [
                    Color.fromARGB(142, 47, 101, 69),
                    Color(0xffd6ecd0)
                  ]),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('reportedContent')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snaphot) {
                  if (snaphot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }
                  if (snaphot.hasData && snaphot.data?.size == 0) {
                    return const Center(
                        child: Text(" لا توجد بلاغات",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )));
                  }

                  return ListView.builder(
                    itemCount: snaphot.data?.docs.length,
                    itemBuilder: (context, index) => reportedContent(
                      snap: snaphot.data?.docs[index].data(),
                      id: snaphot.data?.docs[index].id,
                      reference: snaphot.data!.docs[index].reference,
                    ),
                  );
                }),
          ),
        ));
  }
}
