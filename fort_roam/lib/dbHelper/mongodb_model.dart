// To parse this JSON data, do
//
//     final mongodbModel = mongodbModelFromJson(jsonString);

import 'dart:convert';

MongodbModel mongodbModelFromJson(String str) =>
    MongodbModel.fromJson(json.decode(str));

String mongodbModelToJson(MongodbModel data) => json.encode(data.toJson());

class MongodbModel {
  // Id id;
  String image;
  String description;
  String title;
  String type;
  String subtype;
  String latitude;
  String longitude;
  String street;
  List<Object> reviews;

  MongodbModel({
    // required this.id,
    required this.image,
    required this.description,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.subtype,
    required this.street,
    required this.reviews,
  });

  factory MongodbModel.fromJson(Map<String, dynamic> json) => MongodbModel(
        // id: json["id"] != null
        //     ? Id.fromJson(json["id"])
        //     : Id(oid: ""), // Handle null case
        title: json["title"],
        description: json["description"],
        street: json["street"],
        type: json["type"],
        subtype: json["subtype"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"],
        reviews: List<Object>.from(json["reviews"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        // "_id": id.toJson(),
        "title": title,
        "description": description,
        "type": type,
        "subtype": subtype,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
        "street": street,
        "reviews": reviews,
      };
}

class Id {
  String oid;

  Id({
    required this.oid,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json[
            '\$oid'], 
      );

  Map<String, dynamic> toJson() => {
        '\$oid': oid,
      };
}
