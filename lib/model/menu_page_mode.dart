import 'dart:convert';

class MenuPageModel {
  String id;
  String name;
  RestaurantId restaurantId;
  String description;
  int price;
  List<String> images;
  int timeToPrepare;
  String category;
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
    required this.v,
  });

  factory MenuPageModel.fromRawJson(String str) =>
      MenuPageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuPageModel.fromJson(Map<String, dynamic> json) => MenuPageModel(
        id: json["_id"],
        name: json["name"],
        restaurantId: RestaurantId.fromJson(json["restaurant_id"]),
        description: json["description"],
        price: json["price"],
        images: List<String>.from(json["images"].map((x) => x)),
        timeToPrepare: json["timeToPrepare"],
        category: json["category"],
        v: json["__v"],
      );

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
