
import 'dart:developer';


import 'package:fort_roam/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, collection;
  static connect() async {
    try {
      db = await Db.create(MONGO_CONN_URL);
      await db.open();
      inspect(db);
      collection = db.collection(PLACES);
    } catch (e) {
      print('Error creating database: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await collection.find().toList();
    return arrData;
  }

 
}
