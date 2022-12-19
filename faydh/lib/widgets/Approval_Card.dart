import 'dart:convert';

import 'package:faydh/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final  ref = _firestore.collection("users");

final query = ref.where("role", isEqualTo:"منظمة تجارية");
final query2 = query.where("status", isEqualTo: "0");


class ApprovalCard extends StatefulWidget {
  final snap;
  const ApprovalCard({
    this.snap,
    super.key});

  @override
  State<ApprovalCard> createState() => _ApprovalCardState();
}

class _ApprovalCardState extends State<ApprovalCard> {

  String myUsername = "";
  var seen = false;


void updateStatus(status, id) {
  print(id);

  _firestore.collection("users").doc(id).update({"status": status});
  print("done");

  


}

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0,
            color: Colors.white,
          ),),
          margin :const EdgeInsets.all(8),
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tweetAvatar(),
                  tweetBody(),
                ],
              ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
         
            Container(
              
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                    color: Color.fromARGB(125, 158, 158, 158),
                    spreadRadius: 0.01,
                    blurRadius: 15
                  )] 
                ),
                child: GestureDetector(
                  onTap:() {
                   showDialog(context: context, 
                  builder:  (BuildContext context){
                    return AlertDialog(
                      title: const Text(
                        "تأكيد الموافقة",
                          textAlign: TextAlign.right,
                      ),
                       content:  const Text(
                                    ( " هل أنت متأكد من الموافقة على الشركة ؟ ") ,
                                    textAlign: TextAlign.right,
                                  ),
                        actions: <Widget>[
                           TextButton(
                                      child: const Text("إلغاء"),
                                      onPressed: () {
                                        // callback function for on click event of Cancel button
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("موافق"),
                                      onPressed: () async {
                                     updateStatus("1",  "${widget.snap["uid"].toString()}");
                                     sendApproval( name: "${widget.snap["username"].toString()}",email: "${widget.snap["email"].toString()}" , st: "1" );
                                        Navigator.pop(context);

                                        print("check");
                                      },
                                    ),

                        ],

                    );
                  });
                  },
                  child:  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                       Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                      Text("قبول"),
                     
                    ],
                  )
                ),

                
              ),
            
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                    color: Color.fromARGB(125, 158, 158, 158),
                    spreadRadius: 0.3,
                    blurRadius: 15
                  )] 
                ),
                child: GestureDetector(
                  onTap:() {
                  showDialog(context: context, 
                  builder:  (BuildContext context){
                    return AlertDialog(
                      title: const Text(
                        "تأكيد الرفض",
                          textAlign: TextAlign.right,
                      ),
                       content:  Text(
                                    ( " هل أنت متأكد من رفض الشركة ؟ ") ,
                                    textAlign: TextAlign.right,
                                  ),
                        actions: <Widget>[
                           TextButton(
                                      child: const Text("إلغاء"),
                                      onPressed: () {
                                        // callback function for on click event of Cancel button
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("موافق"),
                                      onPressed: () async {
                                     updateStatus("2",  "${widget.snap["uid"].toString()}");
                                     var email = "${widget.snap["email"].toString()}" ;
                                     print(email);

                                    
                                    sendApproval( name: "${widget.snap["username"].toString()}",email: email , st: "2" );

                                        Navigator.pop(context);

                                        print("check");
                                      },
                                    ),

                        ],

                    );
                  });

                  },
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                      Icons.disabled_by_default,
                      color: Colors.red,
                    ),
                      Text("رفض"),
                     
                    ],
                  )
  
                  ),
                ),
                
            ),
              
         ],


            ),
          ),
         
            ],
          ),
        ),
      ),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.account_circle_rounded,
          color: Color.fromARGB(226, 29, 92, 76),
          size: 40,
        ),
      ),
    );
  }



  Widget tweetBody() {
    //var _dta = "${widget.snap["postImage"].toString()}";
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 2, bottom: 2, left: 2),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20, right: 0, bottom: 2, left: 50),
              child: Text(
                  //"${widget.snap["postText"].toString()}",
                   ( "${" رقم السجل التجاري : " + widget.snap["crNo"].toString()}"),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }


  Widget tweetHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Text(
                  //"${widget.snap["postUserName"].toString()}",
                   ( "${widget.snap["username"].toString()}"),
                  //myUsername,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ],
            ),
          ),
        ),
        //  Spacer(),
      ],
    );
  }



Future sendApproval({
  required String name,
  required String email,
  required var st ,
})async{
  const serviceId = 'service_g4jjg7d';
   var userId= '7hJUinnZHv07_0-Ae' ;
  var templateId = "";
  if(st == "1"){
    templateId = 'template_8ma1ebn';
  }else if(st == "2"){
    templateId = 'template_hc0w3sd';
  }
 
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  var response = await http.post(
    url,
    headers: {
      'origin': 'http:localhost',
      'Content-Type': 'application/json',},
    body: jsonEncode({
      'service_id': serviceId ,
      'user_id': userId,
      'template_id': templateId,
      'template_params':{
        'to_name': name,
         'sender_email': email,
      }
    }), );

  print(response.body);

}



}
