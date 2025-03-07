import 'dart:convert';

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
