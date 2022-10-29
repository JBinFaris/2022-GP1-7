import 'dart:typed_data';
import 'package:faydh/myAwareness.dart';
import 'package:faydh/widgets/my_awerness_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firestore_methods.dart';
import '../services/storage_method.dart';
import '../utilis/utilis.dart';

class EditPost extends StatefulWidget {
  final String title;

  final imgUrl;
  final String newID;

  EditPost({required this.title, required this.imgUrl, required this.newID});

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  Future _selectImage() async {
    Uint8List im = await pickIamge(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  TextEditingController _title = TextEditingController();
  bool _showProgress = false;

  // void dispose() {
  //   super.dispose();
  //   _title.dispose();
  //   _description.dispose();
  //   _price.dispose();
  // }

  _clearThings() {
    _image?.clear();
    _title.clear();
  }

  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
            )
          ],
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "      تحرير المحتوى ",
            ),
          ),
          backgroundColor: Color(0xFF1A4D2E),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: _title,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء كتابة مالايقل عن ٤ أحرف';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'اكتب هنا', hintText: widget.title),
                          ),
                        ),
                        const SizedBox(height: 45.0),
                        _showProgress
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF1A4D2E),
                                ),
                              )
                            : MaterialButton(
                                child: Text("تحديث "),
                                color: Color(0xFF1A4D2E),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _showProgress = true;
                                    });
                                    FirestoreMethods()
                                        .updatePostTwo(
                                            title: _title.text,
                                            id: widget.newID)
                                        .then((value) {
                                      if (value == "success") {
                                        _clearThings();

                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          setState(() {
                                            _showProgress = false;
                                          });
                                        });

                                        showSnackBar(
                                            "تم تحديث المحتوى بنجاح", context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return myAware();
                                        }));
                                      }
                                    });
                                  }
                                },
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
