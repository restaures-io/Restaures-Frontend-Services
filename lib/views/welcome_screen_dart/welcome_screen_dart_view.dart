import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/welcome_screen_dart/welcome_screen_dart_model.dart';
// import controller
import 'package:restaures/controllers/welcome_screen_dart/welcome_screen_dart_controller.dart';
import 'package:restaures/views/login_screen_dart/login_screen_dart_view.dart';
import 'package:restaures/views/onboarding_as/onboarding_as_view.dart';

class WelcomeScreenDartView extends StatelessWidget {
  WelcomeScreenDartView({super.key});

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => OnboardingAsView()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.zero,
      imageAlignment: Alignment.center,
      pageMargin: EdgeInsets.fromLTRB(20, 80, 20, 20),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('icons/restaures.png', 50),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Real-Time Updates",
          body:
              "Stay informed with live notifications about your table status and any changes in wait times.",
          image: _buildImage('utils/welcome/real_time_updates.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Seamless Reservation Management",
          body:
              "Easily modify or cancel your reservations directly from the app, with just a few taps.",
          image: _buildImage('utils/welcome/reservation_management.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Personalized Dining Experience",
          body:
              "Receive tailored recommendations based on your preferences for an enhanced dining experience.",
          image: _buildImage('utils/welcome/personalized_recommendations.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Contactless Check-In",
          body:
              "Check-in effortlessly upon arrival with our contactless solution, ensuring a smooth and safe dining experience.",
          image: _buildImage('utils/welcome/contactless_checkin.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Order Ahead for Faster Service",
          body:
              "Place your order in advance so your meal is ready shortly after you're seated.",
          image: _buildImage('utils/welcome/order_ahead.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
