import 'package:flutter/material.dart';
import 'package:restaures/model/restaurant.dart';
import 'package:restaures/pages/customer/restaurant_screen_user_view.dart';
import 'package:restaures/widgets/custom_card.dart';

class RestaurantListWidget extends StatelessWidget {
  RestaurantListWidget({
    super.key,
    required this.restaurants,
  });
  List<RestaurantModel> restaurants = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestaurantScreenUserView(
                                restaurant: restaurants[index],
                              )));
                },
                child: RestaurantCardWidget(
                  restaurant: restaurants[index],
                )),
          );
        });
  }
}
