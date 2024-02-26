// import 'dart:developer';

// import 'package:fort_roam/dbHelper/constant.dart';
// import 'package:mongo_dart/mongo_dart.dart';

// class MongoDatabase {
//   static var db, userCollection;
//   static connect() async {
//     db = await Db.create(MONGO_CONN_URL);
//     await db.open();
//     // log('Connected to database');
//     userCollection = db.collection(USER_COLLECTION);
//   }
// }
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
      collection = db.collection(COMMERCIAL_COLLECTION);
    } catch (e) {
      print('Error creating database: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await collection.find().toList();
    return arrData;
  }

 
}
