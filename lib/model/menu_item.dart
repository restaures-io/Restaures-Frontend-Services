import 'dart:convert';

class MenuItem {
  String? id;
  String name;
  String? restaurantId;
  String description;
  int price;
  List<String> images;
  int timeToPrepare;
  String category;

  MenuItem({
    this.id,
    required this.name,
    this.restaurantId,
    required this.description,
    required this.price,
    required this.images,
    required this.timeToPrepare,
    required this.category,
  });

  factory MenuItem.fromRawJson(String str) =>
      MenuItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json["_id"],
        name: json["name"],
        restaurantId: json["restaurant_id"],
        description: json["description"],
        price: json["price"],
        images: List<String>.from(json["images"].map((x) => x)),
        timeToPrepare: json["timeToPrepare"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "restaurant_id": restaurantId,
        "description": description,
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
        "timeToPrepare": timeToPrepare,
        "category": category,
      };
}
