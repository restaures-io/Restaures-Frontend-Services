import 'dart:convert';

class EnquiryModel {
  String id;
  CustomerId customerId;
  RestaurantId restaurantId;
  MenuId menuId;
  int quantity;
  int totalPrice;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int timeToPrepare;

  EnquiryModel({
    required this.id,
    required this.customerId,
    required this.restaurantId,
    required this.menuId,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.timeToPrepare,
  });

  factory EnquiryModel.fromRawJson(String str) =>
      EnquiryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EnquiryModel.fromJson(Map<String, dynamic> json) => EnquiryModel(
        id: json["_id"],
        customerId: CustomerId.fromJson(json["customerId"]),
        restaurantId: RestaurantId.fromJson(json["restaurantId"]),
        menuId: MenuId.fromJson(json["menuId"]),
        quantity: json["quantity"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        timeToPrepare: json["timeToPrepare"] ??
            MenuId.fromJson(json["menuId"]).timeToPrepare,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId.toJson(),
        "restaurantId": restaurantId.toJson(),
        "menuId": menuId.toJson(),
        "quantity": quantity,
        "totalPrice": totalPrice,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "timeToPrepare": timeToPrepare,
      };
}

class CustomerId {
  String id;
  String firstName;

  CustomerId({
    required this.id,
    required this.firstName,
  });

  factory CustomerId.fromRawJson(String str) =>
      CustomerId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
        id: json["_id"],
        firstName: json["firstName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
      };
}

class MenuId {
  String id;
  String name;
  String restaurantId;
  String description;
  int price;
  List<String> images;
  int timeToPrepare;
  String category;
  int v;

  MenuId({
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

  factory MenuId.fromRawJson(String str) => MenuId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuId.fromJson(Map<String, dynamic> json) => MenuId(
        id: json["_id"],
        name: json["name"],
        restaurantId: json["restaurant_id"],
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
        "restaurant_id": restaurantId,
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
