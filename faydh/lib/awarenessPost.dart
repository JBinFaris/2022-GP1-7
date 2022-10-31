import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/home_page.dart';
import 'package:faydh/services/firestore_methods.dart';
import 'package:faydh/utilis/utilis.dart';
import 'package:faydh/widgets/all_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class awarenessPost extends StatefulWidget {
  const awarenessPost({super.key});

  @override
  State<awarenessPost> createState() => _HomePageState();
}

class _HomePageState extends State<awarenessPost>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _contentController = TextEditingController();
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

  @override
  void initState() {
    getUser();
    // TODO: implement initState
  }

  getUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      print("ABC");
      if (myUsername == "") {
        // print("value...${value.}");
        myUsername = value["username"].toString();
        print(myUsername);
      } else {
        print("m");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          controller: _contentController,
                          decoration: const InputDecoration(
                            hintText: "اكتب هنا",
                            focusedBorder: UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF1A4D2E)),
                            ),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(300),
                          ],
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

                      SizedBox(
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
                            backgroundColor: Color(0xFF1A4D2E),
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  child: const Text('إضافة'),
                                  onPressed: () {
                                    FirestoreMethods()
                                        .uploadPost(
                                            postUserName: myUsername,
                                            postTitle: _contentController.text,
                                            file: _image)
                                        .then((value) {
                                      if (value == "succces") {
                                        _clearAll();
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF1A4D2E),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(
          Icons.add_outlined,
          size: 50,
        ),
        backgroundColor: Color(0xFF1A4D2E),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('المنتدى التوعوي       ')),
        backgroundColor: Color(0xFF1A4D2E),
        foregroundColor: Color(0xFFF7F7F7),
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
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snaphot) {
            if (snaphot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }

            return ListView.builder(
              itemCount: snaphot.data?.docs.length,
              itemBuilder: (context, index) => AllPostsCard(
                snap: snaphot.data?.docs[index].data(),
              ),
            );
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
    Navigator.of(this.context).pop();
  }
}
