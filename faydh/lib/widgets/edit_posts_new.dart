import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/firestore_methods.dart';
import '../utilis/utilis.dart';

class EditPostNew extends StatefulWidget {
  final String title;
  final String address;
  final String text;
  final String count;
  final String expireDate;

  final String? imgUrl;
  final String? path;
  final String newID;
  final DocumentReference<Map<String, dynamic>> reference;

  EditPostNew({
    required this.title,
    required this.address,
    required this.text,
    required this.count,
    required this.expireDate,
    required this.imgUrl,
    required this.newID,
    required this.path,
    required this.reference,
  });

  @override
  _EditPostNewState createState() => _EditPostNewState();
}

class _EditPostNewState extends State<EditPostNew> {
  Future _selectImage() async {
    Uint8List? im = await pickIamge(ImageSource.gallery);
    if (im != null) {
      setState(() {
        _image = im;
      });
    }
  }

  TextEditingController postTitleTextEditingController =
      TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController foodCountEditingController = TextEditingController();

  String _date = "تاريخ انتهاء الطعام";

  bool _showProgress = false;

  _clearThings() {
    _image = null;
    postTitleTextEditingController.text = "";
    _date = "تاريخ انتهاء الطعام";
    setState(() {});
  }

  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    postTitleTextEditingController.text = widget.title;
    descriptionTextEditingController.text = widget.address;
    addressEditingController.text = widget.text;
    foodCountEditingController.text = widget.count;
    _date = widget.expireDate;
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
                        TextFormField(
                          textAlign: TextAlign.right,
                          controller: postTitleTextEditingController,
                          decoration: const InputDecoration(
                            hintText: "عنوان الاعلان",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF1A4D2E)),
                            ),
                          ),
                          maxLength: 60,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length >= 60) {
                              return 'الحد الأقصى للكتابة هو 60 حرف';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textAlign: TextAlign.right,
                          controller: addressEditingController,
                          decoration: const InputDecoration(
                            hintText: "الوصف",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF1A4D2E)),
                            ),
                          ),
                          maxLength: 300,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length >= 300) {
                              return 'الحد الأقصى للكتابة هو 300 حرف';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textAlign: TextAlign.right,
                          controller: descriptionTextEditingController,
                          decoration: const InputDecoration(
                            hintText: "العنوان",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF1A4D2E)),
                            ),
                          ),
                          maxLength: 60,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length >= 60) {
                              return 'الحد الأقصى للكتابة هو 60 حرف';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textAlign: TextAlign.right,
                          controller: foodCountEditingController,
                          decoration: const InputDecoration(
                            hintText: "كمية الطعام",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF1A4D2E)),
                            ),
                          ),
                          maxLength: 20,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length >= 20) {
                              return _date;
                            }

                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  theme: const DatePickerTheme(
                                    containerHeight: 210.0,
                                  ),
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2050, 12, 31),
                                  onConfirm: (date) {
                                print('confirm $date');
                                _date =
                                    '${date.year} - ${date.month} - ${date.day}';
                                setState(() {});
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            const Icon(
                                              Icons.date_range,
                                              size: 18.0,
                                              color: Color(0xFF1A4D2E),
                                            ),
                                            Text(
                                              " $_date",
                                              style: const TextStyle(
                                                  color: Color(0xFF1A4D2E),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const Text(
                                    "تعديل",
                                    style: TextStyle(
                                      color: Color(0xFF1A4D2E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
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
                                      postTitleTextEditingController.text
                                              .trim() ==
                                          "") {
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
                                          .updatePostThree(
                                        title:
                                            postTitleTextEditingController.text,
                                        oldImage: widget.path,
                                        id: widget.newID,
                                        address:
                                            descriptionTextEditingController
                                                .text,
                                        text: addressEditingController.text,
                                        count: foodCountEditingController.text,
                                        expireDate: _date,
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
