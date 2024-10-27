import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/bottom_navigator_user/bottom_navigator_user_model.dart';

class BottomNavigatorUserController {
  BottomNavigatorUserController();

  void getter(BuildContext context) {
    BottomNavigatorUserModel viewModel =
        Provider.of<BottomNavigatorUserModel>(context, listen: false);
    //TODO Add code here for getter
    viewModel.getter();
  }

  void setter(BuildContext context) {
    BottomNavigatorUserModel viewModel =
        Provider.of<BottomNavigatorUserModel>(context, listen: false);
    //TODO Add code here for setter
    viewModel.setter();
  }

  void update(BuildContext context) {
    BottomNavigatorUserModel viewModel =
        Provider.of<BottomNavigatorUserModel>(context, listen: false);
    //TODO Add code here for update
    viewModel.update();
  }

  void remove(BuildContext context) {
    BottomNavigatorUserModel viewModel =
        Provider.of<BottomNavigatorUserModel>(context, listen: false);
    //TODO Add code here for remove
    viewModel.remove();
  }

  void changeSelectedIndex(BuildContext context, int index) {
    BottomNavigatorUserModel viewModel =
        Provider.of<BottomNavigatorUserModel>(context, listen: false);
    viewModel.changeSelectedIndex(index);
  }
}
