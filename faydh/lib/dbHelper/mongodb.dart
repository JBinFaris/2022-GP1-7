import 'dart:developer';
import 'package:faydh/MongoDBModel.dart';
import 'package:faydh/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, awarCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
    awarCollection = db.collection(AWARPOST_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();

    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getData2() async {
    final arrData = await awarCollection.find().toList();

    return arrData;
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong while inserting data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insert2(MongoDbModel data) async {
    try {
      var result = await awarCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong while inserting data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<Map<String, dynamic>?> getUserData(String id) async {
    try {
      Map<String, dynamic>? result =
          await userCollection!.findOne({'_id': ObjectId.fromHexString(id)});

      if (result != null) {
        return result;
      } else {
        log('data not found');
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>> updateUserData(
      String id, Map<String, dynamic> update) async {
    try {
      WriteResult result = await userCollection!
          .replaceOne({'_id': ObjectId.fromHexString(id)}, update);

      if (result.isSuccess) {
        return {'success': true, 'message': "data updated"};
      } else {
        return {'success': false, 'message': "data not updated"};
      }
    } catch (e) {
      log(e.toString());
      return {'success': false, 'message': e.toString()};
    }
  }
}
