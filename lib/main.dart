import 'package:flutter/material.dart';
import 'package:restaures/components/Theme/global_theme.dart';
import 'package:restaures/pages/welcome_page.dart';
import 'package:restaures/utils/shared_prefrences.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
        child: MaterialApp(
      title: 'Restaures',
      debugShowCheckedModeBanner: false,
      theme: RestauresTheme.themeData,
      builder: (context, child) {
        return ToastificationConfigProvider(
          config: ToastificationConfig(
            marginBuilder: (context, alignment) => const EdgeInsets.all(20),
            alignment: Alignment.center,
            itemWidth: 440,
            animationDuration: const Duration(milliseconds: 500),
          ),
          child: child!,
        );
      },
      home: WelcomeScreenDartView(),
    ));
  }
}
