import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:restaures/pages/customer/favorite_restaurant_customer_view.dart';
import 'package:restaures/pages/onboarding_page.dart';
import 'package:restaures/utils/shared_prefrences.dart';
import 'package:restaures/widgets/custom_carousel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class RestaurantProfileScreen extends StatelessWidget {
  Map<String, dynamic> user =
      jsonDecode(SharedPreferencesService.getString('user'));

  @override
  Widget build(BuildContext context) {
    log('user: $user');
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomCarouselWidget(
                imageList: List<String>.from(user["images"].map((x) => x))),
            SizedBox(height: 20),
            Text(user['name'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(user['restaurantEmail'],
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                SharedPreferencesService.clear();
                toastification.show(
                  title: Text('Logged out successfully'),
                  showIcon: true,
                  type: ToastificationType.success,
                  autoCloseDuration: const Duration(seconds: 5),
                );
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => OnboardingAsView()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
