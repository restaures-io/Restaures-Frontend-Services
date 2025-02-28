import 'package:restaures/model/bank_details.dart';
import 'package:restaures/model/location.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/model/owner.dart';
import 'package:restaures/model/working_day.dart';

class Restaurant {
  final String id;
  final String name;
  final String managementPhone;
  final String restaurantEmail;
  final Location location;
  final List<WorkingDay> workingDays;
  final List<MenuItem> menu;
  final Owner owner;
  final String panNumber;
  final String gstinNumber;
  final BankDetails bankDetails;
  final String fssaiRegistrationNumber;

  Restaurant({
    required this.id,
    required this.name,
    required this.managementPhone,
    required this.restaurantEmail,
    required this.location,
    required this.workingDays,
    required this.menu,
    required this.owner,
    required this.panNumber,
    required this.gstinNumber,
    required this.bankDetails,
    required this.fssaiRegistrationNumber,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      managementPhone: json['managementPhone'],
      restaurantEmail: json['restaurantEmail'],
      location: Location.fromJson(json['location']),
      workingDays: (json['workingDays'] as List)
          .map((day) => WorkingDay.fromJson(day))
          .toList(),
      menu: (json['menu'] as List)
          .map((item) => MenuItem.fromJson(item))
          .toList(),
      owner: Owner.fromJson(json['owner']),
      panNumber: json['panNumber'],
      gstinNumber: json['gstinNumber'],
      bankDetails: BankDetails.fromJson(json['bankDetails']),
      fssaiRegistrationNumber: json['fssaiRegistrationNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'managementPhone': managementPhone,
      'restaurantEmail': restaurantEmail,
      'location': location.toJson(),
      'workingDays': workingDays.map((day) => day.toJson()).toList(),
      'menu': menu.map((item) => item.toJson()).toList(),
      'owner': owner.toJson(),
      'panNumber': panNumber,
      'gstinNumber': gstinNumber,
      'bankDetails': bankDetails.toJson(),
      'fssaiRegistrationNumber': fssaiRegistrationNumber,
    };
  }
}
