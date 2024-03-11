// // To parse this JSON data, do
// //
// //     final mongodbModel = mongodbModelFromJson(jsonString);

// import 'dart:convert';

// MongodbModel mongodbModelFromJson(String str) => MongodbModel.fromJson(json.decode(str));

// String mongodbModelToJson(MongodbModel data) => json.encode(data.toJson());

// class MongodbModel {
//     Id id;
//   //  String address;
//   //  String description;
//   //  String name;
//   //  String webSiteUrl;
//    // String typeOfThePlace;

//     MongodbModel({
//         required this.id,
//      //   required this.address,
//      //   required this.description,
//      //   required this.name,
//       //   required this.webSiteUrl,
//        //  required this.typeOfThePlace,
//     });

//     factory MongodbModel.fromJson(Map<String, dynamic> json) => MongodbModel(
//   id: json["id"] != null ? Id.fromJson(json["id"]) : Id(oid: ""), // Handle null case
//  // address: json["address"],
//  // description: json["description"],
//  // name: json["name"],
//  // webSiteUrl: json["web_site_URL"],
//  // typeOfThePlace: json["type_of_the_place"],
// );


//     Map<String, dynamic> toJson() => {
//         "_id": id.toJson(),
//        // "address": address,
//       //  "description": description,
//     //    "name": name,
//       //  "web_site_URL": webSiteUrl,
//      //   "type_of_the_place": typeOfThePlace,
//     };
// }

// class Id {
//     String oid;

//     Id({
//         required this.oid,
//     });

//     factory Id.fromJson(Map<String, dynamic> json) => Id(
//         oid: json["\u0024oid"],
//     );

//     Map<String, dynamic> toJson() => {
//         "\u0024oid": oid,
//     };
// }
