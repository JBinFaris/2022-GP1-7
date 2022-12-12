import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/AdminMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ApproveBusiness extends StatefulWidget {
  const ApproveBusiness({super.key});

  @override
  State<ApproveBusiness> createState() => _ApproveBusinessState();
}

class _ApproveBusinessState extends State<ApproveBusiness> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        automaticallyImplyLeading: false,
        title: const Center(child: Text('      التحقق من الشركات')),
        backgroundColor: Color.fromARGB(151, 26, 77, 46),
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
                  colors: [Color.fromARGB(142, 47, 101, 69), Color(0xffd6ecd0)]),
            ),
           /* child: StreamBuilder(
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

                return ListView.builder(
                  itemCount: snaphot.data?.docs.length,
                  itemBuilder: (context, index) => MyCard(
                    id: snaphot.data?.docs[index].id,
                    snap: snaphot.data?.docs[index].data(),
                    reference: snaphot.data!.docs[index].reference,
                  ),
                );
              },
            )),*/

        // Add new product

        // backgroundColor:Color.fromARGB(255, 235, 241, 233),
      ),
    ) );
  }
}