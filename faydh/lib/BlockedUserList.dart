import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/widgets/BListCards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockedUserList extends StatefulWidget {
  const BlockedUserList({super.key});

  @override
  State<BlockedUserList> createState() => _BlockedUserListState();
}

class _BlockedUserListState extends State<BlockedUserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('  قائمة المحظورين '),
        backgroundColor: const Color(0xFF1A4D2E),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color.fromARGB(225, 255, 255, 255),
          ),
        ),
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
                  .collection("users")
                  .where('Active', isEqualTo: false)
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
                      child: Text("! لا يوجد مستخدمين محظورين",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )));
                }

                return ListView.builder(
                  itemCount: snaphot.data?.docs.length,
                  itemBuilder: (context, index) => bListCards(
                    snap: snaphot.data?.docs[index].data(),
                  ),
                );
              },
            )), /**/

        // Add new product

        // backgroundColor:Color.fromARGB(255, 235, 241, 233),
      ),
    );
  }
}
