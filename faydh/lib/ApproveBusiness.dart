import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/models/user_model.dart';
import 'package:faydh/widgets/Approval_Card.dart';
import 'package:flutter/material.dart';

class ApproveBusiness extends StatefulWidget {
  const ApproveBusiness({super.key});

  @override
  State<ApproveBusiness> createState() => _ApproveBusinessState();
}

class _ApproveBusinessState extends State<ApproveBusiness> {
  var dataloaded;
  List<User> usersList = [];

  @override
  void dispose() {
    dataloaded = false;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dataloaded = false;
    //getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('التحقق من الشركات'),
          backgroundColor: const Color(0xFF1A4D2E),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Color.fromARGB(225, 255, 255, 255),
            ),
          )),
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
                  .where('status', isEqualTo: "0")
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

                return ListView.builder(
                  itemCount: snaphot.data?.docs.length,
                  itemBuilder: (context, index) => ApprovalCard(
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
