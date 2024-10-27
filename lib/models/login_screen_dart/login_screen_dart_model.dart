import 'package:flutter/material.dart';

enum LoginScreenDartModelStatus {
  Ended,
  Loading,
  Error,
}

class LoginScreenDartModel extends ChangeNotifier {
  LoginScreenDartModelStatus _status;
  String _errorCode;
  String _errorMessage;
  bool _isPasswordVisible;

  bool get isPasswordVisible => _isPasswordVisible;
  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  LoginScreenDartModelStatus get status => _status;

  LoginScreenDartModel()
      : _status = LoginScreenDartModelStatus.Ended,
        _isPasswordVisible = false,
        _errorCode = '',
        _errorMessage = '';

  LoginScreenDartModel.instance()
      : _status = LoginScreenDartModelStatus.Ended,
        _errorCode = '',
        _isPasswordVisible = false,
        _errorMessage = '' {
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

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
}
