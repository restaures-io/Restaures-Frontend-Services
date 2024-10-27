import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/account_user/account_user_model.dart';
// import controller
import 'package:restaures/controllers/account_user/account_user_controller.dart';

class AccountUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountUserController viewController = AccountUserController();
    return ChangeNotifierProvider<AccountUserModel>(
      create: (context) => AccountUserModel.instance(),
      child: Consumer<AccountUserModel>(
        builder: (context, viewModel, child) {
          return Container(
              //TODO Add layout or component here
              );
        },
      ),
    );
  }
}