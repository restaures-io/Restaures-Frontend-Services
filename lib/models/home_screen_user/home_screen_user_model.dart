import 'package:flutter/material.dart';

enum HomeScreenUserModelStatus {
  Ended,
  Loading,
  Error,
}

class HomeScreenUserModel extends ChangeNotifier {
  HomeScreenUserModelStatus _status;
  String _errorCode;
  String _errorMessage;

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  HomeScreenUserModelStatus get status => _status;

  HomeScreenUserModel()
      : _status = HomeScreenUserModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '';

  HomeScreenUserModel.instance()
      : _status = HomeScreenUserModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '' {
    //TODO Add code here
  }

  void getter() {
    _status = HomeScreenUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = HomeScreenUserModelStatus.Ended;
    notifyListeners();
  }

  void setter() {
    _status = HomeScreenUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = HomeScreenUserModelStatus.Ended;
    notifyListeners();
  }

  void update() {
    _status = HomeScreenUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = HomeScreenUserModelStatus.Ended;
    notifyListeners();
  }

  void remove() {
    _status = HomeScreenUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = HomeScreenUserModelStatus.Ended;
    notifyListeners();
  }
}
