import 'dart:convert';

class RestaurantModel {
  List<String> images;
  String id;
  String name;
  Location location;
  List<WorkingDay> workingDays;
  List<String> favoriteBy;
  DateTime createdAt;
  DateTime updatedAt;

  RestaurantModel({
    required this.images,
    required this.id,
    required this.name,
    required this.location,
    required this.workingDays,
    required this.favoriteBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RestaurantModel.fromRawJson(String str) =>
      RestaurantModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        images: List<String>.from(json["images"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        location: Location.fromJson(json["location"]),
        workingDays: List<WorkingDay>.from(
            json["workingDays"].map((x) => WorkingDay.fromJson(x))),
        favoriteBy: json["favoriteBy"] != null
            ? List<String>.from(json["favoriteBy"].map((x) => x))
            : [],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "_id": id,
        "name": name,
        "location": location.toJson(),
        "workingDays": List<dynamic>.from(workingDays.map((x) => x.toJson())),
        "favoriteBy": List<dynamic>.from(favoriteBy.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Location {
  String id;
  String address;
  String city;
  String state;
  String zipCode;
  String country;
  double latitude;
  double longitude;
  int v;

  Location({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.v,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["_id"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        country: json["country"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "__v": v,
      };
}

class WorkingDay {
  String id;
  String days;
  String openingTime;
  String closingTime;
  int v;

  WorkingDay({
    required this.id,
    required this.days,
    required this.openingTime,
    required this.closingTime,
    required this.v,
  });

  factory WorkingDay.fromRawJson(String str) =>
      WorkingDay.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        id: json["_id"],
        days: json["days"],
        openingTime: json["openingTime"],
        closingTime: json["closingTime"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "days": days,
        "openingTime": openingTime,
        "closingTime": closingTime,
        "__v": v,
      };
}
