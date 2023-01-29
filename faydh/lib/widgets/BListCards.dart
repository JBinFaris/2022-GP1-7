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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: const EdgeInsets.fromLTRB(18, 3, 0, 0),
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
                    padding: const EdgeInsets.fromLTRB(0, 3, 35, 0),
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





}

  
