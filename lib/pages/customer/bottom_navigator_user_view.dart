import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:restaures/pages/customer/customer_profile_view.dart';
import 'package:restaures/pages/customer/enquiry_customer_view.dart';
import 'package:restaures/pages/customer/favorite_restaurant_customer_view.dart';
import 'package:restaures/pages/customer/food_items_customer_view.dart';
import 'package:restaures/pages/customer/search_page.dart';
import 'package:restaures/pages/customer/trending_restaurant_page.dart';

class BottomNavigatorUserView extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    TrendingRestaurantView(),
    EnquiryCustomerView(),
    SearchView(),
    ProfileScreen(),
  ];

  const BottomNavigatorUserView({super.key});

  @override
  State<BottomNavigatorUserView> createState() =>
      _BottomNavigatorUserViewState();
}

class _BottomNavigatorUserViewState extends State<BottomNavigatorUserView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: BottomNavigatorUserView._widgetOptions.elementAt(_selectedIndex),
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.query_builder,
                    text: 'Enquiry',
                  ),
                  GButton(
                    icon: LineIcons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  log(_selectedIndex.toString());
                },
              )),
        ),
      ),
    );
  }
}
