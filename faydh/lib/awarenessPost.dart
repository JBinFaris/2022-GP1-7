import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class awarenessPost extends StatefulWidget {
  const awarenessPost({super.key});

  @override
  State<awarenessPost> createState() => _HomePageState();
}

class _HomePageState extends State<awarenessPost> {
  @override
  PickedFile? pickedImage;
  File? imageFile;

  final TextEditingController _nameController = TextEditingController();
  // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);//piiicc

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.1, 0.9],
            colors: [Color.fromARGB(142, 26, 77, 46), Color(0xffd6ecd0)]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Center(child: Text('المنتدى التوعوي       ')),
          backgroundColor: Color(0xFFF7F7F7),
          foregroundColor: Color(0xFF1A4D2E),
          leading: IconButton(
            icon: Icon(Icons.add_circle),
            tooltip: 'إضافة',
            color: Color(0xFF1A4D2E),
            focusColor: Color(0xFFD6ECD0),
            iconSize: 40,
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
                          TextField(
                            textAlign: TextAlign.right,
                            controller: _nameController,
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
                          const SizedBox(
                            height: 20,
                          ),
                          //اضبط لونها ومكاناها
                          FloatingActionButton(
                            onPressed: () => _showOption(context),
                            child: const Icon(Icons.add_photo_alternate),
                            backgroundColor: Color(0xFF1A4D2E),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  child: const Text('إضافة'),
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF1A4D2E),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
        body: const MyStatelessWidget(),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Color(0xFF1A4D2E),
          iconSize: 35,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_rounded),
              label: 'المنتدى التوعوي',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'الملف الشخصي',
            ),
          ],
          //  currentIndex: _selectedIndex,
          // selectedItemColor: Colors.amber[800],
          // onTap: _onItemTapped,
        ),
        floatingActionButton: FloatingActionButton.large(
            onPressed: () {},
            child: new Image.asset('assets/images/faydh2.png'),

            // backgroundColor:Color.fromARGB(255, 235, 241, 233),

            backgroundColor: Colors.white),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  _showOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('make a choice'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Gallery'),
                      onTap: () => _imageFromGallery(context),
                    ),
                    ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                      onTap: () => _imageFromCamera(context),
                    ),
                  ],
                ),
              ),
            ));
  }

  Future _imageFromGallery(BuildContext context) async {
    imageFile = File(await ImagePicker()
        .getImage(source: ImageSource.gallery)
        .then((pickedFile) => pickedFile?.path ?? ''));
  }

  Future _imageFromCamera(BuildContext context) async {
    imageFile = File(await ImagePicker()
        .getImage(source: ImageSource.gallery)
        .then((pickedFile) => pickedFile?.path ?? ''));
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: SizedBox(
            width: 50,
          ),
          trailing: Icon(
            Icons.account_circle_rounded,
            size: 40,
          ),
        ),
      ),
    );
  }
}
