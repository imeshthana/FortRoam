// To parse this JSON data, do
//
//     final mongodbModel = mongodbModelFromJson(jsonString);

import 'dart:convert';

MongodbModel mongodbModelFromJson(String str) => MongodbModel.fromJson(json.decode(str));

String mongodbModelToJson(MongodbModel data) => json.encode(data.toJson());

class MongodbModel {
  //Id id;
  String type;
  String subtype;
  String title;
  String description;
  String street;
  String image;
  String latitude;
  String longitude;

  MongodbModel({
   // required this.id,
    required this.type,
    required this.subtype,
    required this.title,
    required this.description,
    required this.street,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  factory MongodbModel.fromJson(Map<String, dynamic> json) => MongodbModel(
       // id: Id.fromJson(json['_id']), // Update this line to match the MongoDB ID field name
        type: json["type"],
        subtype: json["subtype"],
        title: json["title"],
        description: json["description"],
        street: json["street"],
        image: json["image"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
       // "_id": id.toJson(),
        "type": type,
        "subtype": subtype,
        "title": title,
        "description": description,
        "street": street,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Id {
  String oid;

  Id({
    required this.oid,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json['\$oid'], // Update this line to match the MongoDB ID field name
      );

  Map<String, dynamic> toJson() => {
        '\$oid': oid,
      };
}
