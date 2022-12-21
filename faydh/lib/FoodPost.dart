import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/Database/database.dart';
import 'package:faydh/Database/drop_down_provider.dart';
import 'package:faydh/upload_api.dart';
import 'package:faydh/widgets/custom_drop_down.dart';
import 'package:faydh/widgets/edit_posts_new.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class FoodPostScreen extends StatefulWidget {
  const FoodPostScreen({Key? key}) : super(key: key);

  @override
  State<FoodPostScreen> createState() => _FoodPostScreenState();
}

String? selectedValue;

final List<String> myList = [
  "الرياض",
  "جدة",
  "مكة المكرمة",
  "المدينة المنورة",
  "سلطانة",
  "تبوك",
  "الطائف",
  "بريدة",
  " خميس مشيط",
  "الهفوف",
  "المبرز",
  " حفر الباطن",
  "حائل",
  "نجران",
  "الجبيل",
  "أبها",
  "ينبع",
  "الخُبر",
  "عنيزة",
  "عرعر",
  "سكاكا",
  "سكاكا",
  "القريات",
  "الظهران",
  "القطيف",
  "الباحة",
  "تاروت",
  "البيشة",
  "الرس",
  "الشفا",
  "سيهات",
  "المذنب",
  "الخفجي",
  "الدوادمي",
  "صبيا",
  "الزلفي",
  " أبو العريش",
  "الصفوى",
  "رابغ",
  "رحيمة",
  "الطريف",
  "عفيف",
  "طبرجل",
  "الدلم",
  "أملج",
  "العلا",
  "بقيق",
  " بدر حنين",
  "صامطة",
  "الوجه",
  "البكيرية",
  "نماص",
  "السليل",
  "تربة",
  "الجموم",
  "ضباء",
  "الطريف",
  "القيصومة",
  "البطالية",
  "المنيزلة",
  "المجاردة",
  "تنومة",
  "تنومة"
];

class _FoodPostScreenState extends State<FoodPostScreen> {
  bool arrow = false;

  String Uid = FirebaseAuth.instance.currentUser!.uid;
  initState() {
    getData();
  }

  Future<String?> getData() async {
    var a = await FirebaseFirestore.instance.collection("users").doc(Uid).get();

    final myrole = a['role'];
    if (myrole == "فرد") {
      setState(() {
        arrow = true;
      });
    }
  }

  @override
  String id = FirebaseAuth.instance.currentUser!.uid;

  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> foodPostStream = FirebaseFirestore.instance
        .collection('foodPost')
        .where('Cid', isEqualTo: id)
        .orderBy(
          "docId",
          descending: true,
        )
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: arrow
          ? AppBar(
              elevation: 2.0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF1A4D2E),
              title: const Text(" اعلانات المتبرعين"),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color.fromARGB(225, 255, 255, 255),
                  ),
                )
              ],
            )
          : AppBar(
              elevation: 2.0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF1A4D2E),
              title: const Center(child: Text('اعلانات المتبرعين ')),
            ),
      body: StreamBuilder<QuerySnapshot>(
        stream: foodPostStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('حدث خطأ ما');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading..."));
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              // reverse: false,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    elevation: 4.0,
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                          ), // so?
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "نوع الطعام:  ${data['postTitle'].toString()}",
                                //data['postTitle'],
                                style: const TextStyle(
                                  color: Color(0xFF1A4D2E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "موقع الإستلام:  ${data['postAdress'].toString()}",
                                // data['postAdress'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 144, 177, 135),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "كمية الطعام:  ${data['food_cont'].toString()}",
                                //data['food_cont'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 144, 177, 135),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                data['postText'],
                                style: const TextStyle(
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Image.network(
                              data['postImage'],
                              height: 200,
                              width: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, bottom: 8),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "تاريخ الانتهاء : ${data['postExp'].toString()}",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 177, 135),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, bottom: 8),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "تاريخ الإضافة:  ${data['postDate'].toString().split(" ").first}",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 177, 135),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditPostNew(
                                                  newID: document.id,
                                                  title: "${data["postTitle"]}",
                                                  address:
                                                      "${data["postAdress"]}",
                                                  text: "${data["postText"]}",
                                                  count: "${data["food_cont"]}",
                                                  expireDate:
                                                      "${data["postExp"]}",
                                                  imgUrl:
                                                      "${data["postImage"]}",
                                                  path: "${data["pathImage"]}",
                                                  reference: document.reference
                                                      as DocumentReference<
                                                          Map<String, dynamic>>,
                                                )),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(226, 29, 92, 76),
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: const Text(
                                                'تأكيد الحذف',
                                                textAlign: TextAlign.right,
                                              ),
                                              content: const Text(
                                                "هل أنت متأكد من حذف المحتوى ؟ ",
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
                                                    print(
                                                        document.id.toString());

                                                    document.reference.delete();

                                                    Navigator.pop(context);

                                                    print("check");
                                                  },
                                                ),
                                              ]);
                                        });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 172, 8, 8),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mySheet(context);
        },
        backgroundColor: const Color(0xFF1A4D2E),
        child: const Icon(Icons.add),
      ),
    );
  }

  ///

  // bottom sheett code

  mySheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return const MyStateFullForSheet();
        });
  }
}

class MyStateFullForSheet extends StatefulWidget {
  const MyStateFullForSheet({
    super.key,
  });

// problem is fixed
  @override
  State<MyStateFullForSheet> createState() => _MyStateFullForSheetState();
}

class _MyStateFullForSheetState extends State<MyStateFullForSheet> {
  File? fileImage;
  UploadTask? taskImage;
  String? urlDownloadImage;

  /// selectFileImage code
  Future selectFileImage() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    ); // sorry? yes ofcouese
    // no no
    // this package is alllow to picker every type of file but here i have apply just images

    if (results == null) return;
    final paths = results.files.single.path!;

    setState(() => fileImage = File(paths));

    uploadFileImage();
  }

  // problem is this our bottomsheet is not loading after data geting...
  ///uploadfileImage code
  Future uploadFileImage() async {
    if (fileImage == null) return;

    final fileNameImage = basename(fileImage!.path);
    final destinations = 'fileImages/$fileNameImage';

    taskImage = FirebaseApi.uploadFile(destinations, fileImage!);
    setState(() {});

    if (taskImage == null) return;

    final snapshot = await taskImage!.whenComplete(() {});
    urlDownloadImage = await snapshot.ref.getDownloadURL();
    setState(() {});

    print('Download-Image-Link: $urlDownloadImage');
  }

  final _formKey = GlobalKey<FormState>();
  String _date = "تاريخ انتهاء الطعام";
  TextEditingController postTitleTextEditingController =
      TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController foodCountEditingController = TextEditingController();

  TextEditingController addressEditingController = TextEditingController();
  TextEditingController nigbehoodEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DropDownProvider>(context);
    User? user = FirebaseAuth.instance.currentUser;

    final fileNameImage =
        fileImage != null ? basename(fileImage!.path) : "لم يتم اختيار صورة";

    return Padding(
      padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textAlign: TextAlign.right,
                controller: postTitleTextEditingController,
                decoration: const InputDecoration(
                  hintText: "نوع الطعام ",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A4D2E)),
                  ),
                ),
                maxLength: 60,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length >= 60) {
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
                controller: descriptionTextEditingController,
                decoration: const InputDecoration(
                  hintText: "الوصف",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A4D2E)),
                  ),
                ),
                maxLength: 300,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length >= 300) {
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

              /// this one
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                textAlign: TextAlign.right,
                controller: foodCountEditingController,
                decoration: const InputDecoration(
                  hintText: "كمية الطعام",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A4D2E)),
                  ),
                ),
                maxLength: 20,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length >= 20) {
                    return 'الحد الأقصى للكتابة هو 20 حرف';
                  }

                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),

              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: DropdownButtonFormField<String>(
                        alignment: Alignment.centerRight,
                        value: selectedValue,
                        icon: const Align(
                          alignment: Alignment.centerRight,
                        ),
                        elevation: 16,
                        borderRadius: BorderRadius.circular(40),
                        decoration: InputDecoration(
                          // errorStyle: TextStyle( align: TextAlign.right),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color(0xffd6ecd0),
                              width: 1.0,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color(0xffd6ecd0),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color(0xffd6ecd0),
                              width: 1.0,
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          label: const Align(
                              alignment: Alignment.centerRight,
                              child: Text('المدينه')),
                          // contentPadding: EdgeInsets.only(left:230),
                        ),
                        items: myList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'الرجاء اختيار المدينة';
                          }
                        },
                        onChanged: (String? value) {
                          //Do something when changing the item if you want.
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                        onSaved: (value) {
                          selectedValue = value.toString();
                        },
                      ))),

              TextFormField(
                textAlign: TextAlign.right,
                controller: nigbehoodEditingController,
                decoration: const InputDecoration(
                  hintText: "الحي",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A4D2E)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال إسم الحي';
                  }

                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),

              const SizedBox(
                height: 8,
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
                        maxTime: DateTime(2050, 12, 31), onConfirm: (date) {
                      print('confirm $date');
                      _date = '${date.year}-${date.month}-${date.day}';
                      setState(() {});
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      " $_date",
                                      style: const TextStyle(
                                          color: Color(0xFF1A4D2E),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 20,
              ),
              //اضبط لونها ومكاناها

              const SizedBox(
                height: 10,
              ),

              fileImage == null
                  ? Align(
                      alignment: Alignment.center,
                      child: Text(
                        "$fileNameImage",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 15,
              ),
              fileImage != null
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            fileImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 100,
                        width: 100,
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    backgroundColor: const Color(0xFF1A4D2E),
                    onPressed: () {
                      selectFileImage();
                      print("object");
                    },
                    child: const Icon(Icons.add_photo_alternate),
                  ),
                  urlDownloadImage == null
                      ? Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            child: const Text('إضافة الإعلان'),
                          ),
                        )
                      : Align(
                          //
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (_) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: const Text('تأكيد!'),
                                          content: const Text(
                                              'عند موافقتك لنشر الاعلان لن تتمكن من تعديل أو حذف الإعلان إذا تم حجزه. '),
                                          actions: [
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("إلغاء"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    print(
                                                        "dataurl: ${urlDownloadImage}");
                                                    print(
                                                        "useris:: ${user!.displayName}");
                                                    if (_formKey.currentState!
                                                            .validate() &&
                                                        urlDownloadImage !=
                                                            null) {
                                                      Database.addFoodPostData(
                                                        context: context,
                                                        docId: DateTime.now()
                                                            .toString(),
                                                        userUid:
                                                            user.uid.toString(),
                                                        userPost: user
                                                            .displayName
                                                            .toString(),
                                                        postTitle:
                                                            postTitleTextEditingController
                                                                .text
                                                                .toString(),
                                                        postText:
                                                            descriptionTextEditingController
                                                                .text
                                                                .toString(),

                                                        ///
                                                        postAdress: selectedValue
                                                                .toString() +
                                                            ", " +
                                                            nigbehoodEditingController
                                                                .text
                                                                .toString(),

                                                        postImage:
                                                            urlDownloadImage
                                                                .toString(),
                                                        postExp:
                                                            _date.toString(),
                                                        food_cont:
                                                            foodCountEditingController
                                                                .text
                                                                .toString(),
                                                      );
                                                      data.clear();
                                                      Navigator.pop(context);
                                                    } else {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "الرجاء تعبئة كافة الحقول",
                                                        backgroundColor:
                                                            Colors.red,
                                                      );
                                                    }
                                                  },
                                                  child: const Text("موافق"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A4D2E),
                            ),
                            child: const Text(' إضافة الإعلان'),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
