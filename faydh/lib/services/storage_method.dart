import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, String>> uploadImageToStorage(
      String childName, Uint8List file, bool isPost,
      {String? filename}) async {
    Reference ref = _storage.ref().child(childName).child(filename ??
        "${_firebaseAuth.currentUser!.uid}-${DateTime.now().millisecondsSinceEpoch}");

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    String path = snap.ref.name;
    return {'downloadUrl': downloadUrl, 'path': path};
  }

  Future<void> removeImage(String childName, String path) async {
    Reference ref = _storage.ref().child(childName).child(path);
    return ref.delete();
  }
}
