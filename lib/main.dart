import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaures/components/Theme/global_theme.dart';
import 'package:restaures/models/bottom_navigator_user/bottom_navigator_user_model.dart';
import 'package:restaures/models/login_screen_dart/login_screen_dart_model.dart';
import 'package:restaures/views/welcome_screen_dart/welcome_screen_dart_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add the model to the list of providers
        ChangeNotifierProvider(
            create: (context) => LoginScreenDartModel.instance()),

        ChangeNotifierProvider(
            create: (context) => BottomNavigatorUserModel.instance()),
      ],
      child: MaterialApp(
        title: 'Restaures',
        debugShowCheckedModeBanner: false,
        theme: RestauresTheme.themeData,
        home: WelcomeScreenDartView(),
      ),
    );
  }
}
