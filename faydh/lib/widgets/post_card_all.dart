// import 'package:flutter/material.dart';
//
// class PostCardAll extends StatelessWidget {
//   final snap;
//
//   const PostCardAll({required this.snap, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = "${snap["postImage"].toString()}";
//     return Card(
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//           width: 0,
//           color: Colors.white,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       margin: const EdgeInsets.all(8),
//       child: ListTile(
//         leading: SizedBox(
//           width: 50,
//         ),
//         title: Text(
//           "${snap["postTitle"].toString()}",
//           // data.content,
//
//           textAlign: TextAlign.right,
//         ),
//         subtitle: SizedBox(
//           height: 100,
//           width: 100,
//           child: provider == null
//               ? Text('No image selected.')
//               : Image(
//                   image: NetworkImage("${snap["postImage"].toString()}"),
//                 ),
//         ),
//         trailing: Icon(
//           Icons.account_circle_rounded,
//           size: 40,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PostCardAll extends StatelessWidget {
  final snap;

  PostCardAll({required this.snap, super.key});

  @override
  Widget build(BuildContext context) {
    var image = "${snap["postImage"].toString()}";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tweetAvatar(),
                tweetBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: const CircleAvatar(
        child: Icon(
          Icons.account_circle_rounded,
          size: 40,
        ),
      ),
    );
  }

  Widget tweetBody() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            tweetHeader(),
            SizedBox(
              height: 150,
              width: 150,
              child: Image(
                  image: NetworkImage(
                "${snap["postImage"].toString()}",
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget tweetHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            "${snap["postUserName"].toString()}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Text("${snap["postTitle"].toString()}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );
  }
}
