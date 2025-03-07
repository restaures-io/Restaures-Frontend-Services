import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:restaures/pages/restaurant/add_menu_restaurant_view.dart';
import 'package:restaures/pages/restaurant/enquiry_restaurant_view.dart';
import 'package:restaures/pages/restaurant/restaurant_profile_view.dart';

// import model
class BottomNavigatorRestaurantView extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    AddMenuRestaurantView(),
    EnquiryRestaurantView(),
    RestaurantProfileScreen(),
  ];

  const BottomNavigatorRestaurantView({super.key});

  @override
  State<BottomNavigatorRestaurantView> createState() =>
      _BottomNavigatorRestaurantViewState();
}

class _BottomNavigatorRestaurantViewState
    extends State<BottomNavigatorRestaurantView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: BottomNavigatorRestaurantView._widgetOptions
            .elementAt(_selectedIndex),
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
                    icon: LineIcons.receipt,
                    text: 'Add Menu',
                  ),
                  GButton(
                    icon: Icons.query_builder,
                    text: 'Enquiries',
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
                },
              )),
        ),
      ),
    );
  }
}
