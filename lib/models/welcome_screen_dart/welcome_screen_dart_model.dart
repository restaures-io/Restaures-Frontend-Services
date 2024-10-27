import 'package:flutter/material.dart';

enum WelcomeScreenDartModelStatus {
  Ended,
  Loading,
  Error,
}

class WelcomeScreenDartModel extends ChangeNotifier {
  WelcomeScreenDartModelStatus _status;
  final String _errorCode;
  final String _errorMessage;

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  WelcomeScreenDartModelStatus get status => _status;

  WelcomeScreenDartModel()
      : _status = WelcomeScreenDartModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '';

  WelcomeScreenDartModel.instance()
      : _status = WelcomeScreenDartModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '' {
    //TODO Add code here
  }

  void getter() {
    _status = WelcomeScreenDartModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = WelcomeScreenDartModelStatus.Ended;
    notifyListeners();
  }

  void setter() {
    _status = WelcomeScreenDartModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = WelcomeScreenDartModelStatus.Ended;
    notifyListeners();
  }

  void update() {
    _status = WelcomeScreenDartModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = WelcomeScreenDartModelStatus.Ended;
    notifyListeners();
  }

  void remove() {
    _status = WelcomeScreenDartModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = WelcomeScreenDartModelStatus.Ended;
    notifyListeners();
  }
}
