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
  List<Map<String, dynamic>> reviews;

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
        reviews: List<Map<String, dynamic>>.from(json["reviews"] ?? []),
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

  // Map<String, dynamic> toReviewMap() {
  //   return {
  //     'name': name,
  //     'content': content,
  //     'rating': rating,
  //   };
  // }
}

class Id {
  String oid;

  Id({
    required this.oid,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json[
            '\$oid'], // Update this line to match the MongoDB ID field name
      );

  Map<String, dynamic> toJson() => {
        '\$oid': oid,
      };
}
