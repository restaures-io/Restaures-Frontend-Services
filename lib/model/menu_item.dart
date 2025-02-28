// To parse this JSON data, do
//
//     final menuItem = menuItemFromJson(jsonString);

import 'dart:convert';

MenuItem menuItemFromJson(String str) => MenuItem.fromJson(json.decode(str));

String menuItemToJson(MenuItem data) => json.encode(data.toJson());

class MenuItem {
  String? name;
  String? description;
  List<String>? images;
  int? price;
  int? timeToPrepare;
  String? category;

  MenuItem({
    this.name,
    this.description,
    this.images,
    this.price,
    this.timeToPrepare,
    this.category,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        price: json["price"],
        timeToPrepare: json["timeToPrepare"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "price": price,
        "timeToPrepare": timeToPrepare,
        "category": category,
      };
}
