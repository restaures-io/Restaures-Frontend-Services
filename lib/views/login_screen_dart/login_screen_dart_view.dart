import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getwidget/components/text_field/gf_text_field_rounded.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/components/Global/enums.dart';
// import model
import 'package:restaures/models/login_screen_dart/login_screen_dart_model.dart';
// import controller
import 'package:restaures/controllers/login_screen_dart/login_screen_dart_controller.dart';
import 'package:restaures/views/User/bottom_navigator_user/bottom_navigator_user_view.dart';
import 'package:toastification/toastification.dart';

class LoginScreenDartView extends StatelessWidget {
  // Type of LoginScreenDartView
  final UserRole userType;

  LoginScreenDartView({super.key, required this.userType});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LoginScreenDartController viewController = LoginScreenDartController();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Login As ${userType == UserRole.restaurant ? 'Restaurant' : 'User'}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  GFTextFieldRounded(
                    backgroundcolor: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.5),
                    controller: emailController,
                    editingbordercolor: Theme.of(context).colorScheme.primary,
                    idlebordercolor: Theme.of(context).colorScheme.primary,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderwidth: 1,
                    cornerradius: 10,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    hintText: 'Email',
                    focusedbordercolor: Theme.of(context).colorScheme.onPrimary,
                    cursorRadius: const Radius.circular(10),
                    iconPrefix: Icon(Icons.email,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(400)),
                  ),
                  Consumer<LoginScreenDartModel>(
                      builder: (context, viewModel, child) {
                    return GFTextFieldRounded(
                      controller: passwordController,
                      backgroundcolor: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      editingbordercolor: Theme.of(context).colorScheme.primary,
                      idlebordercolor: Theme.of(context).colorScheme.primary,
                      borderwidth: 1,
                      cornerradius: 10,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Theme.of(context).colorScheme.primary,
                      hintText: 'Password',
                      focusedbordercolor: Theme.of(context).colorScheme.primary,
                      cursorRadius: const Radius.circular(10),
                      iconPrefix: Icon(Icons.lock,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(400)),
                      obscureText: !viewModel.isPasswordVisible,
                      obscuringCharacter: '•',
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Forgot Password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                )),
                      ),
                      Row(
                        children: [
                          Consumer<LoginScreenDartModel>(
                              builder: (context, viewModel, child) {
                            return Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: WidgetStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                    width: 1.0,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              onChanged: (value) {
                                viewController
                                    .tooglePasswordVisibility(context);
                              },
                              activeColor:
                                  Theme.of(context).colorScheme.secondary,
                              checkColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              value: viewModel.isPasswordVisible,
                            );
                          }),
                          Text('Show Password',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: GFButton(
                      borderShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        viewController.setLoginRequestModel(context,
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                        ApiResponse? response = await viewController.login(
                          context,
                        );
                        if (response != null && response.success) {
                          log('Success');
                          toastification.show(
                            title: Text(response.message),
                            showIcon: true,
                            type: ToastificationType.success,
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigatorUserView()));
                        } else if (response == null) {
                          log('Error:500');
                          toastification.show(
                            title: Text('Error:500'),
                            showIcon: true,
                            type: ToastificationType.error,
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        }
                      },
                      text: 'Login',
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                      ),
                      icon: Icon(Icons.login,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 25),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                          )),
                      TextButton(
                        onPressed: () {},
                        child: Text('Sign Up',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
