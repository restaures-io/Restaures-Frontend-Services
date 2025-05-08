import 'dart:convert';

import 'package:restaures/model/enquiry.dart';

class MenuPageModel {
  String id;
  String name;
  RestaurantId restaurantId;
  String description;
  int price;
  List<String> images;
  int timeToPrepare;
  String category;
  List<Rating> ratings;
  double avgRating = 0;
  int v;

  MenuPageModel({
    required this.id,
    required this.name,
    required this.restaurantId,
    required this.description,
    required this.price,
    required this.images,
    required this.timeToPrepare,
    required this.category,
    required this.ratings,
    required this.avgRating,
    required this.v,
  });

  factory MenuPageModel.fromRawJson(String str) =>
      MenuPageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuPageModel.fromJson(Map<String, dynamic> json) {
    List<Rating> ratingsList = (json["ratings"] as List<dynamic>?)
            ?.map((x) => Rating.fromJson(x))
            .toList() ??
        [];

    double avgRating = ratingsList.isNotEmpty
        ? ratingsList.map((e) => e.score).reduce((a, b) => a + b) /
            ratingsList.length
        : 0.0;

    return MenuPageModel(
      id: json["_id"],
      name: json["name"],
      restaurantId: RestaurantId.fromJson(json["restaurant_id"]),
      description: json["description"],
      price: json["price"],
      images: List<String>.from(json["images"].map((x) => x)),
      timeToPrepare: json["timeToPrepare"],
      category: json["category"],
      ratings: ratingsList,
      avgRating: avgRating,
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "restaurant_id": restaurantId.toJson(),
        "description": description,
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
        "timeToPrepare": timeToPrepare,
        "category": category,
        "__v": v,
      };
}

class RestaurantId {
  String id;
  String name;

  RestaurantId({
    required this.id,
    required this.name,
  });

  factory RestaurantId.fromRawJson(String str) =>
      RestaurantId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantId.fromJson(Map<String, dynamic> json) => RestaurantId(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
