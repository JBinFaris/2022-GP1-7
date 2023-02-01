import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class bListCards extends StatefulWidget {
  final snap;
  const bListCards({this.snap,super.key});

  @override
  State<bListCards> createState() => _bListCardsState();
}

class _bListCardsState extends State<bListCards> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
         elevation: 0,
        color: Colors.transparent,
           child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 62, 112, 82).withOpacity(0.9),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tweetAvatar(),
                  tweetBody(),
                ],
              ),

     
         
            ],
          ),
        ),
      ),
    ),);
  }

  Widget tweetAvatar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 40, 0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(3, 5, 5, 5),
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.block,
            color: Color.fromARGB(225, 135, 11, 11),
            size: 70,
          ),
        ),
      ),
    );
  }



  Widget tweetBody() {
    //var _dta = "${widget.snap["postImage"].toString()}";
    return Expanded(
      child: Column(
   //     crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      //    tweetHeader(),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 0, bottom: 2, left: 2),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, right: 0, bottom: 2, left: 30),
              child: 
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 5, 0),
                    child: Text(
              //"${widget.snap["postText"].toString()}",
               ( "${" اسم المستخدم: " + widget.snap["username"].toString()}"),
               textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                
              )),
                  ),
              Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 65, 0),
                child: Text(
                //"${widget.snap["postText"].toString()}",
                 ( "${" البريد الإلكتروني: " + widget.snap["email"].toString()}"),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
              ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(28, 3, 0, 0),
                  child: Text(
              //"${widget.snap["postText"].toString()}",
               ( "${" نوع المستخدم : " + widget.snap["role"].toString()}"),
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
              )),
                ),
               Padding(
                    padding: const EdgeInsets.fromLTRB(13, 3, 35, 0),
                 child: Text(
              //"${widget.snap["postText"].toString()}",
                 ( "${" رقم المستخدم : " + widget.snap["phoneNumber"].toString()}"),
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
              )),
               ),

                ],
              ), 
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(75, 0, 0, 10),
            child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: 150,
                                height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(
                                        25.0, 10.0, 25.0, 10.0),
                                    backgroundColor:
                                        const Color.fromARGB(255, 18, 57, 20),
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            title: const Text(
                                              "تأكيد الغاء الحظر",
                                              textAlign: TextAlign.right,
                                            ),
                                            content: const Text(
                                              "هل أنت متأكد من الغاء حظر المستخدم ؟ ",
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
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(widget.snap["uid"]
                                                          .toString())
                                                      .update({'Active': true});
                                              
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text(
                                    ' الغاء  حظر  المستخدم  ',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
          )
                   

        ],
      ),
    );
  }


  



}

  
