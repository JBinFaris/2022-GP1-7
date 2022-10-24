import 'dart:developer';
import 'package:faydh/dbHelper/SignUpModel.dart';
import 'package:faydh/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);

    await db.open();

    inspect(db);

    userCollection = db.collection(USER_COLLECTION);
  }
  static Future<void> insert(MongoDbModel data) async{
    try{


    }catch(e){
      print(e.toString());
    }


  }
}
