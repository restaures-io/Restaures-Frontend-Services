import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:restaures/components/Global/enums.dart';
import 'package:restaures/views/login_screen_dart/login_screen_dart_view.dart';

class OnboardingAsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: Image.asset(
                  'assets/icons/restaures.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: GFButton(
                      borderShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const LoginScreenDartView(
                              userType: UserRole.customer,
                            ),
                          ),
                        );
                      },
                      text: 'Continue as User',
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 15,
                      ),
                      icon: Icon(Icons.person,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 25),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const Divider(
                    height: 50,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: GFButton(
                      borderShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const LoginScreenDartView(
                              userType: UserRole.restaurant,
                            ),
                          ),
                        );
                      },
                      text: 'Continue as Restaurant',
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 15,
                      ),
                      icon: Icon(Icons.restaurant,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 25),
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
