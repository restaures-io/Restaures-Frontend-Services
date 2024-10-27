import 'package:flutter/material.dart';

enum RestaurantScreenUserModelStatus {
  Ended,
  Loading,
  Error,
}

class RestaurantScreenUserModel extends ChangeNotifier {
  RestaurantScreenUserModelStatus _status;
  String _errorCode;
  String _errorMessage;

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  RestaurantScreenUserModelStatus get status => _status;

  RestaurantScreenUserModel()
      : _status = RestaurantScreenUserModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '';

  RestaurantScreenUserModel.instance()
      : _status = RestaurantScreenUserModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '' {
    //TODO Add code here
  }

  void getter() {
    _status = RestaurantScreenUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = RestaurantScreenUserModelStatus.Ended;
    notifyListeners();
  }

  void setter() {
    _status = RestaurantScreenUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = RestaurantScreenUserModelStatus.Ended;
    notifyListeners();
  }

  void update() {
    _status = RestaurantScreenUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = RestaurantScreenUserModelStatus.Ended;
    notifyListeners();
  }

  void remove() {
    _status = RestaurantScreenUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = RestaurantScreenUserModelStatus.Ended;
    notifyListeners();
  }
}
