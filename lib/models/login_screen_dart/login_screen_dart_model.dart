import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:restaures/components/Global/api_constants.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/services/api_service.dart';
import 'package:toastification/toastification.dart';

enum LoginScreenDartModelStatus {
  Ended,
  Loading,
  Error,
}

class LoginScreenDartModel extends ChangeNotifier {
  LoginScreenDartModelStatus _status;
  String _errorCode;
  String _errorMessage;
  final ApiService _apiService;
  late final LoginResponseUser _loginResponseUser;
  LoginRequestUser? _loginRequestUser;
  bool _isPasswordVisible;

  LoginResponseUser get loginResponseUser => _loginResponseUser;
  LoginRequestUser? get loginRequestUser => _loginRequestUser;
  bool get isPasswordVisible => _isPasswordVisible;
  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  LoginScreenDartModelStatus get status => _status;

  LoginScreenDartModel()
      : _status = LoginScreenDartModelStatus.Ended,
        _isPasswordVisible = false,
        _errorCode = '',
        _errorMessage = '',
        _apiService = ApiService();

  LoginScreenDartModel.instance()
      : _status = LoginScreenDartModelStatus.Ended,
        _errorCode = '',
        _isPasswordVisible = false,
        _errorMessage = '',
        _apiService = ApiService() {
    //TODO Add code here
  }

  void getter() {
    _status = LoginScreenDartModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = LoginScreenDartModelStatus.Ended;
    notifyListeners();
  }

  void setter() {
    _status = LoginScreenDartModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = LoginScreenDartModelStatus.Ended;
    notifyListeners();
  }

  void update() {
    _status = LoginScreenDartModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = LoginScreenDartModelStatus.Ended;
    notifyListeners();
  }

  void remove() {
    _status = LoginScreenDartModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = LoginScreenDartModelStatus.Ended;
    notifyListeners();
  }

  void setLoginRequestUser({
    required String email,
    required String password,
  }) {
    _loginRequestUser = LoginRequestUser(email: email, password: password);
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<ApiResponse?> login() async {
    _status = LoginScreenDartModelStatus.Loading;
    notifyListeners();
    ApiResponse response = await _apiService.post(
        ApiUrl.customerLogin, _loginRequestUser!.toJson());

    if (response.success) {
      _loginResponseUser = LoginResponseUser.fromJson(response.data);
    }

    notifyListeners();
    return response;
  }
}

class LoginRequestUser {
  String email;
  String password;

  LoginRequestUser({
    required this.email,
    required this.password,
  });

  factory LoginRequestUser.fromRawJson(String str) =>
      LoginRequestUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRequestUser.fromJson(Map<String, dynamic> json) =>
      LoginRequestUser(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class LoginResponseUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String profilePicture;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String refreshToken;
  String accessToken;

  LoginResponseUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.refreshToken,
    required this.accessToken,
  });

  factory LoginResponseUser.fromRawJson(String str) =>
      LoginResponseUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseUser.fromJson(Map<String, dynamic> json) =>
      LoginResponseUser(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profilePicture: json["profilePicture"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        refreshToken: json["refresh_token"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "profilePicture": profilePicture,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "refresh_token": refreshToken,
        "access_token": accessToken,
      };
}
