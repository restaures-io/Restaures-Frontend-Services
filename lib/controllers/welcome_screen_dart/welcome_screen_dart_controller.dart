import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/welcome_screen_dart/welcome_screen_dart_model.dart';

class WelcomeScreenDartController {
  WelcomeScreenDartController();
  
  void getter(BuildContext context) {
    WelcomeScreenDartModel viewModel = Provider.of<WelcomeScreenDartModel>(context, listen: false);
    //TODO Add code here for getter
    viewModel.getter();
  }

  void setter(BuildContext context) {
    WelcomeScreenDartModel viewModel = Provider.of<WelcomeScreenDartModel>(context, listen: false);
    //TODO Add code here for setter
    viewModel.setter();
  }

  void update(BuildContext context) {
    WelcomeScreenDartModel viewModel = Provider.of<WelcomeScreenDartModel>(context, listen: false);
    //TODO Add code here for update
    viewModel.update();
  }

  void remove(BuildContext context) {
    WelcomeScreenDartModel viewModel = Provider.of<WelcomeScreenDartModel>(context, listen: false);
    //TODO Add code here for remove
    viewModel.remove();
  }
}