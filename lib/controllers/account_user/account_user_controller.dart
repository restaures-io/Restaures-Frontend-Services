import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/account_user/account_user_model.dart';

class AccountUserController {
  AccountUserController();
  
  void getter(BuildContext context) {
    AccountUserModel viewModel = Provider.of<AccountUserModel>(context, listen: false);
    //TODO Add code here for getter
    viewModel.getter();
  }

  void setter(BuildContext context) {
    AccountUserModel viewModel = Provider.of<AccountUserModel>(context, listen: false);
    //TODO Add code here for setter
    viewModel.setter();
  }

  void update(BuildContext context) {
    AccountUserModel viewModel = Provider.of<AccountUserModel>(context, listen: false);
    //TODO Add code here for update
    viewModel.update();
  }

  void remove(BuildContext context) {
    AccountUserModel viewModel = Provider.of<AccountUserModel>(context, listen: false);
    //TODO Add code here for remove
    viewModel.remove();
  }
}