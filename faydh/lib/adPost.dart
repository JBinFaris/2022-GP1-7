import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/models/post_model.dart';
import 'package:faydh/models/user_model.dart';
import 'package:faydh/services/firestore_methods.dart';
import 'package:faydh/utilis/utilis.dart';
import 'package:faydh/widgets/all_foodPosts.dart';
import 'package:faydh/models/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class adPost extends StatefulWidget {
  const adPost({super.key});

  @override
  State<adPost> createState() => _HomePageState();
}

class _HomePageState extends State<adPost> with AutomaticKeepAliveClientMixin {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discreptionController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();

  Uint8List? _image;

  /// seelct image
  Future selectImage() async {
    Uint8List? im = await pickIamge(ImageSource.gallery);
    if (im != null) {
      setState(() {
        _image = im;
      });
    }
  }

  String myUsername = "";
  var dataoaded;
  List<UserData> usersList = [];
  List<Posts> postList = [];

  @override
  void dispose() {
    dataoaded = false;
    super.dispose();
  }

  @override
  void initState() {
    dataoaded = false;
    //getUser();
    // TODO: implement initState
  }

  assignUserNamesToPosts(List<QuerySnapshot<Map<String, dynamic>>> docs) {}

  Future getAllUsers() async {
    var collection = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await collection.get();

    List<dynamic> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in allData) {
      usersList.add(UserData(
          email: element['email'],
          role: element['role'],
          uid: element['uid'],
          phoneNumber: element['phoneNumber'],
          username: element['username']));
    }

    setState(() {
      dataoaded = true;
    });
  }

  getUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (myUsername == "") {
        // print("value...${value.}");
        setState(() {
          myUsername = value["username"].toString();
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!dataoaded) getAllUsers();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext ctx) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: "عنوان الإعلان",
                            focusedBorder: UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF1A4D2E)),
                            ),
                          ),
                          maxLength: 60,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            } else if (value.length > 60) {
                              return 'الحد الأقصى للكتابة هو 60 حرف';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),

                      Form(
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _contentController,
                          decoration: const InputDecoration(
                            hintText: "الموقع",
                            focusedBorder: UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF1A4D2E)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }

                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),

                      Form(
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _discreptionController,
                          decoration: const InputDecoration(
                            hintText: "وصف الإعلان ",
                            focusedBorder: UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF1A4D2E)),
                            ),
                          ),
                          maxLength: 300,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            } else if (value.length > 300) {
                              return 'الحد الأقصى للكتابة هو 300 حرف';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),

                      Form(
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _expirationController,
                          decoration: const InputDecoration(
                            hintText: "تاريخ الانتهاء",
                            focusedBorder: UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF1A4D2E)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }

                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      //اضبط لونها ومكاناها

                      const SizedBox(
                        height: 10,
                      ),

                      _image != null
                          ? Center(
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image(
                                    image: MemoryImage(
                                      _image!,
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            )
                          : Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 100,
                                width: 100,
                              ),
                            ),

                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              selectImage();
                            },
                            child: const Icon(Icons.add_photo_alternate),
                            backgroundColor: const Color(0xFF1A4D2E),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                child: const Text('إضافة'),
                                onPressed: () {
                                  if (_image == null &&
                                      _contentController.text == "") {
                                    Fluttertoast.showToast(
                                        msg: "أدخل نصًا أو حدد صورة",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black54,
                                        textColor: Colors.white);
                                  } else {
                                    DateTime now = DateTime.now();
                                    String formattedDate =
                                        DateFormat('kk:mm:ss EEE d MMM')
                                            .format(now);
                                    FirestoreMethods()
                                        .uploadPost(
                                            //postUserName: myUsername,
                                            postText: _contentController.text,
                                            file: _image,
                                            postDate: now)
                                        .then((value) {
                                      if (value == "succces") {
                                        _clearAll();
                                        _titleController.clear();
                                        _discreptionController.clear();
                                        _expirationController.clear();
                                      }
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1A4D2E),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        child: const Icon(
          Icons.add_outlined,
          size: 50,
        ),
        backgroundColor: const Color(0xFF1A4D2E),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('صفحة التبرعات')),
        backgroundColor: const Color(0xFF1A4D2E),
        foregroundColor: const Color(0xFFF7F7F7),
      ),
      body: Container(
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
              .orderBy('postDate', descending: true)
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

            if (!dataoaded) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else {
              QuerySnapshot<Object?>? querySnapshot = snaphot.data;

              List<dynamic>? allData =
                  querySnapshot?.docs?.map((doc) => doc.data()).toList();
              for (var element in allData!) {
                postList.add(Posts.allPostsConstructor(
                    Cid: element['Cid'],
                    postUserName: (element['postUserName'] == null) ? "" : "",
                    postText: element['postText'],
                    postImage: element['postImage'],
                    pathImage: element['pathImage'],
                    userId: element['userId'],
                    postDate: DateTime.fromMicrosecondsSinceEpoch(
                        element['postDate'].millisecondsSinceEpoch)));
              }

              for (var i = 0; i < usersList.length; i++) {
                for (var j = 0; j < postList.length; j++) {
                  if (usersList[i].uid == postList[j].userId) {
                    postList[j].postUserName = usersList[i].username;
                  }
                }
              }

              return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) => AllPostsCard(
                  postData: postList[index],
                ),
              );
              // return ListView.builder(
              //   itemCount: snaphot.data?.docs.length,
              //   itemBuilder: (context, index) => AllPostsCard(
              //     snap: snaphot.data?.docs[index].data(),
              //   ),
              // );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();

  void _clearAll() {
    _contentController.text = "";
    _image = null;
    postList.clear();
    Navigator.of(this.context).pop();
  }
}
