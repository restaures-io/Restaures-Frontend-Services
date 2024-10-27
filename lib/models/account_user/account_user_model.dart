import 'package:flutter/material.dart';

enum AccountUserModelStatus {
  Ended,
  Loading,
  Error,
}

class AccountUserModel extends ChangeNotifier {
  AccountUserModelStatus _status;
  String _errorCode;
  String _errorMessage;

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  AccountUserModelStatus get status => _status;

  AccountUserModel()
      : _status = AccountUserModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '';

  AccountUserModel.instance()
      : _status = AccountUserModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '';
  //TODO Add code here

  void getter() {
    _status = AccountUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = AccountUserModelStatus.Ended;
    notifyListeners();
  }

  void setter() {
    _status = AccountUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = AccountUserModelStatus.Ended;
    notifyListeners();
  }

  void update() {
    _status = AccountUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = AccountUserModelStatus.Ended;
    notifyListeners();
  }

  void remove() {
    _status = AccountUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = AccountUserModelStatus.Ended;
    notifyListeners();
  }
}
