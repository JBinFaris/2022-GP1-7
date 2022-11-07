import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/firestore_methods.dart';
import '../utilis/utilis.dart';

class EditPost extends StatefulWidget {
  final String title;

  final String? imgUrl;
  final String? path;
  final String newID;
  final DocumentReference<Map<String, dynamic>> reference;

  EditPost({
    required this.title,
    required this.imgUrl,
    required this.newID,
    required this.path,
    required this.reference,
  });

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  Future _selectImage() async {
    Uint8List? im = await pickIamge(ImageSource.gallery);
    if (im != null) {
      setState(() {
        _image = im;
      });
    }
  }

  final _title = TextEditingController();
  bool _showProgress = false;

  _clearThings() {
    _image = null;
    _title.text = "";
    setState(() {});
  }

  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _title.text = widget.title;
    super.initState();
  }

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
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
            )
          ],
          title: const Align(
            alignment: Alignment.center,
            child: Text(
              "      تحرير المحتوى ",
            ),
          ),
          backgroundColor: const Color(0xFF1A4D2E),
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
                            maxLength: 300,
                            controller: _title,
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
                            decoration: const InputDecoration(
                              labelText: 'اكتب هنا',
                              hintText: "اكتب هنا",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    color: Colors.grey,
                                    child: Image(
                                      width: 100,
                                      height: 100,
                                      image: MemoryImage(
                                        _image!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    color: Colors.grey,
                                    height: 100,
                                    width: 100,
                                    child: widget.imgUrl != null &&
                                            widget.imgUrl!.isNotEmpty
                                        ? Image(
                                            image: NetworkImage(widget.imgUrl!),
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: 100,
                                          )
                                        : Container(),
                                  ),
                                ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FloatingActionButton(
                            onPressed: () {
                              _selectImage();
                            },
                            backgroundColor: const Color(0xFF1A4D2E),
                            child: const Icon(Icons.add_photo_alternate),
                          ),
                        ),
                        const SizedBox(height: 45.0),
                        _showProgress
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF1A4D2E),
                                ),
                              )
                            : MaterialButton(
                                color: const Color(0xFF1A4D2E),
                                onPressed: () async {
                                  if (_image == null &&
                                      _title.text.trim() == "") {
                                    Fluttertoast.showToast(
                                        msg: "أدخل نصًا أو حدد صورة",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black54,
                                        textColor: Colors.white);
                                  } else {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _showProgress = true;
                                      });

                                      FirestoreMethods()
                                          .updatePostTwo(
                                        title: _title.text,
                                        oldImage: widget.path,
                                        id: widget.newID,
                                        file: _image,
                                        reference: widget.reference,
                                      )
                                          .then((value) {
                                        if (value == "success") {
                                          _clearThings();
                                          setState(() {
                                            _showProgress = false;
                                          });

                                          showSnackBar("تم تحديث المحتوى بنجاح",
                                              context);
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    }
                                  }
                                },
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: const Text("تحديث "),
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
