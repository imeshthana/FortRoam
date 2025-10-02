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
  // static late Db db;
  // static late DbCollection collection;
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

  static Future<void> addReview(
      String placeTitle, Object review) async {
    try {
      if (db == null || !db.isConnected) {
        await connect();
      }
      final result = await collection.update(
        where.eq('title', placeTitle),
        modify.push('reviews', review),
      );
      print('Review added successfully: $result');
    } catch (e) {
      print('Error adding review: $e');
    }
  }
}
