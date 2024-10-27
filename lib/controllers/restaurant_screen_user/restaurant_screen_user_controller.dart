import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/restaurant_screen_user/restaurant_screen_user_model.dart';

class RestaurantScreenUserController {
  RestaurantScreenUserController();
  
  void getter(BuildContext context) {
    RestaurantScreenUserModel viewModel = Provider.of<RestaurantScreenUserModel>(context, listen: false);
    //TODO Add code here for getter
    viewModel.getter();
  }

  void setter(BuildContext context) {
    RestaurantScreenUserModel viewModel = Provider.of<RestaurantScreenUserModel>(context, listen: false);
    //TODO Add code here for setter
    viewModel.setter();
  }

  void update(BuildContext context) {
    RestaurantScreenUserModel viewModel = Provider.of<RestaurantScreenUserModel>(context, listen: false);
    //TODO Add code here for update
    viewModel.update();
  }

  void remove(BuildContext context) {
    RestaurantScreenUserModel viewModel = Provider.of<RestaurantScreenUserModel>(context, listen: false);
    //TODO Add code here for remove
    viewModel.remove();
  }
}