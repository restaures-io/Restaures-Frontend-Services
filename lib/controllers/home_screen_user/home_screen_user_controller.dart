import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/home_screen_user/home_screen_user_model.dart';

class HomeScreenUserController {
  HomeScreenUserController();
  
  void getter(BuildContext context) {
    HomeScreenUserModel viewModel = Provider.of<HomeScreenUserModel>(context, listen: false);
    //TODO Add code here for getter
    viewModel.getter();
  }

  void setter(BuildContext context) {
    HomeScreenUserModel viewModel = Provider.of<HomeScreenUserModel>(context, listen: false);
    //TODO Add code here for setter
    viewModel.setter();
  }

  void update(BuildContext context) {
    HomeScreenUserModel viewModel = Provider.of<HomeScreenUserModel>(context, listen: false);
    //TODO Add code here for update
    viewModel.update();
  }

  void remove(BuildContext context) {
    HomeScreenUserModel viewModel = Provider.of<HomeScreenUserModel>(context, listen: false);
    //TODO Add code here for remove
    viewModel.remove();
  }
}