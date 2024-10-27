import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/bottom_navigator_user/bottom_navigator_user_model.dart';
// import controller
import 'package:restaures/controllers/bottom_navigator_user/bottom_navigator_user_controller.dart';
import 'package:restaures/views/User/home_screen_user/home_screen_user_view.dart';

class BottomNavigatorUserView extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreenUserView(),
    const Text(
      'Likes',
      style: optionStyle,
    ),
    const Text(
      'Search',
      style: optionStyle,
    ),
    const Text(
      'Profile',
      style: optionStyle,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    BottomNavigatorUserController viewController =
        BottomNavigatorUserController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<BottomNavigatorUserModel>(
            builder: (context, viewModel, child) {
          return Center(
            child: _widgetOptions.elementAt(viewModel.selectedIndex),
          );
        }),
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Consumer<BottomNavigatorUserModel>(
                builder: (context, viewModel, child) {
              return GNav(
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
                    icon: LineIcons.heart,
                    text: 'Likes',
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
                selectedIndex: viewModel.selectedIndex,
                onTabChange: (index) {
                  viewController.changeSelectedIndex(context, index);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
