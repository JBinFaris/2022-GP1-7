import 'dart:convert';
import 'dart:io';
import 'package:faydh/MongoDBModel.dart';
import 'package:faydh/dbHelper/mongodb.dart';
import 'package:faydh/individual.dart';
import 'package:faydh/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongo_dart/mongo_dart.dart' show Db, GridFS;

class awarenessPost extends StatefulWidget {
  const awarenessPost({super.key});

  @override
  State<awarenessPost> createState() => _HomePageState();
}

class _HomePageState extends State<awarenessPost>
    with AutomaticKeepAliveClientMixin {
  @override
  TextEditingController contentController = TextEditingController();
  final File? _picController = new File('file.txt'); //ماتأكدت
  String userPost = '';
  String s = '';

  // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);//piiicc
  final url = [
    "mongodb:replicaSet=<MySet>&authSource=admin&retryWrites=true&w=majority",
    "mongodb:replicaSet=<MySet>&authSource=admin&retryWrites=true&w=majority",
    "mongodb:replicaSet=<MySet>&authSource=admin&retryWrites=true&w=majority"
  ];

  final picker = ImagePicker();
  PickedFile? pickedImage;
  File? imageFile;
  late File _image;
  late GridFS bucket;
  // AnimationController _animationController;
  //Animation<Color> _colorTween;
  ImageProvider? provider;
  var flag = false;
  @override
  Widget build(BuildContext context) {
    void _clearAll() {
      contentController.text = "";
      Navigator.of(this.context).pop();
    }

    Future<void> _insertData(String content) async {
      //Navigator.of(this.context).pop();
      var _id = M.ObjectId();
      final data = MongoDbModel(
        id: _id,
        content: content,
      );
      var result = await MongoDatabase.insert2(data);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Inserted Id :" + _id.$oid)));

      _clearAll();
    }

    return Container(
      child: Scaffold(
        body: const MyStatelessWidget(),
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
                            controller: contentController,
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
                                  onPressed: () {
                                    // userPost = contentController.text;

                                    _insertData(contentController.text);
                                  },
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

        /*bottomNavigationBar: BottomNavigationBar(
          fixedColor: Color(0xFF1A4D2E),
          iconSize: 35,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_rounded),
              label: 'المنتدى التوعوي',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'الملف الشخصي',
            ),
          ],
          type: BottomNavigationBarType.fixed,

          //  currentIndex: _selectedIndex,
          // selectedItemColor: Colors.amber[800],
          // onTap: _onItemTapped,
        ),
        floatingActionButton: FloatingActionButton.large(
            onPressed: () {},
            child: new Image.asset('assets/imgs/Faydh2.png'),

            // backgroundColor:Color.fromARGB(255, 235, 241, 233),

            backgroundColor: Colors.white),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
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
                      onTap: () => {
                        //_imageFromGallery()
                      },
                    ),
                    /*    ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                      onTap: () => _imageFromCamera(),
                    ),*/
                  ],
                ),
              ),
            ));
  }
/*
  Future _imageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    var _cmpressed_image;
    PickedFile? pickedImage;
    File? imageFile;
    if (pickedFile != null) {
      try {
        _cmpressed_image = await FlutterImageCompress.compressWithFile(
            pickedFile.path ?? "",
            format: CompressFormat.heic,
            quality: 70);
      } catch (e) {
        _cmpressed_image = await FlutterImageCompress.compressWithFile(
            pickedFile.path ?? "",
            format: CompressFormat.jpeg,
            quality: 70);
      }
      setState(() {
        flag = true;
      });
      Map<String, dynamic> image = {
        "_id": pickedFile.path.split("/").last,
        "data": base64Encode(_cmpressed_image) ?? ""
      };
      var res = await bucket.chunks.insert(image);
      var img =
          await bucket.chunks.findOne({"_id": pickedFile.path.split("/").last});
      setState(() {
        provider = MemoryImage(base64Decode(img!["data"]));
        flag = false;
      });
    }
  }

  Future connection() async {
    Db _db = new Db.pool(url);
    await _db.open(secure: true);
    bucket = GridFS(_db, "image");
  }*/

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

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
        body: SafeArea(
            child: FutureBuilder(
                future: MongoDatabase.getData2(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      var totalData = snapshot.data.length;
                      print("Total Data" + totalData.toString());
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(
                                MongoDbModel.fromJson(snapshot.data[index]));
                          });
                    } else {
                      return Center(
                        child: Text("No data available"),
                      );
                    }
                  }
                })),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget displayCard(MongoDbModel data) {
    var provider;
    return Card(
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
        title: Text(
          "${data.content}",
          // data.content,

          textAlign: TextAlign.right,
        ),
        subtitle: Container(
          child: provider == null
              ? Text('No image selected.')
              : Image(
                  image: provider as ImageProvider,
                ), 
        ),
        trailing: Icon(
          Icons.account_circle_rounded,
          size: 40,
        ),
      ),
    );
  }
}
