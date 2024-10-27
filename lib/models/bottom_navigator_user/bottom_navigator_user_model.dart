import 'dart:ffi';

import 'package:flutter/material.dart';

enum BottomNavigatorUserModelStatus {
  Ended,
  Loading,
  Error,
}

class BottomNavigatorUserModel extends ChangeNotifier {
  BottomNavigatorUserModelStatus _status;
  String _errorCode;
  String _errorMessage;
  int _selectedIndex;

  String get errorCode => _errorCode;
  int get selectedIndex => _selectedIndex;
  String get errorMessage => _errorMessage;
  BottomNavigatorUserModelStatus get status => _status;

  BottomNavigatorUserModel()
      : _status = BottomNavigatorUserModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '',
        _selectedIndex = 0;

  BottomNavigatorUserModel.instance()
      : _status = BottomNavigatorUserModelStatus.Ended,
        _errorCode = '',
        _errorMessage = '',
        _selectedIndex = 0 {
    //TODO Add code here
  }

  void getter() {
    _status = BottomNavigatorUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = BottomNavigatorUserModelStatus.Ended;
    notifyListeners();
  }

  void setter() {
    _status = BottomNavigatorUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = BottomNavigatorUserModelStatus.Ended;
    notifyListeners();
  }

  void update() {
    _status = BottomNavigatorUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = BottomNavigatorUserModelStatus.Ended;
    notifyListeners();
  }

  void remove() {
    _status = BottomNavigatorUserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = BottomNavigatorUserModelStatus.Ended;
    notifyListeners();
  }

  void changeSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
