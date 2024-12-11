import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaures/components/Global/api_response.dart';
// import model
import 'package:restaures/models/login_screen_dart/login_screen_dart_model.dart';

class LoginScreenDartController {
  LoginScreenDartController();

  void getter(BuildContext context) {
    LoginScreenDartModel viewModel =
        Provider.of<LoginScreenDartModel>(context, listen: false);
    //TODO Add code here for getter
    viewModel.getter();
  }

  void setter(BuildContext context) {
    LoginScreenDartModel viewModel =
        Provider.of<LoginScreenDartModel>(context, listen: false);
    //TODO Add code here for setter
    viewModel.setter();
  }

  void update(BuildContext context) {
    LoginScreenDartModel viewModel =
        Provider.of<LoginScreenDartModel>(context, listen: false);
    //TODO Add code here for update
    viewModel.update();
  }

  void remove(BuildContext context) {
    LoginScreenDartModel viewModel =
        Provider.of<LoginScreenDartModel>(context, listen: false);
    //TODO Add code here for remove
    viewModel.remove();
  }

  void tooglePasswordVisibility(BuildContext context) {
    LoginScreenDartModel viewModel =
        Provider.of<LoginScreenDartModel>(context, listen: false);
    viewModel.togglePasswordVisibility();
  }

  void setLoginRequestModel(
    BuildContext context, {
    required String email,
    required String password,
  }) {
    LoginScreenDartModel viewModel =
        Provider.of<LoginScreenDartModel>(context, listen: false);
    viewModel.setLoginRequestUser(email: email, password: password);
  }

  Future<ApiResponse?> login(BuildContext context) async {
    LoginScreenDartModel viewModel =
        Provider.of<LoginScreenDartModel>(context, listen: false);
    return await viewModel.login();
  }
}
