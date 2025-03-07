import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_card/image_card.dart';
import 'package:provider/provider.dart';
import 'package:restaures/model/restaurant.dart';
import 'package:restaures/pages/customer/restaurant_screen_user_view.dart';
import 'package:restaures/service/restaurant_service.dart';
import 'package:restaures/widgets/custom_card.dart';
import 'package:restaures/widgets/custom_carousel.dart';
import 'package:restaures/widgets/custom_list.dart';

class TrendingRestaurantView extends StatefulWidget {
  const TrendingRestaurantView({super.key});

  @override
  State<TrendingRestaurantView> createState() => _TrendingRestaurantViewState();
}

class _TrendingRestaurantViewState extends State<TrendingRestaurantView> {
  List<String> imageList = [
    'https://firebasestorage.googleapis.com/v0/b/restaures-8e685.appspot.com/o/Banners%2FScreenshot%202025-03-03%20205614.png?alt=media&token=9d1a296d-9989-4b32-9e9b-9961dcf26548',
    'https://firebasestorage.googleapis.com/v0/b/restaures-8e685.appspot.com/o/Banners%2FScreenshot%202025-03-03%20205455.png?alt=media&token=9f9affe4-e503-492c-adb0-343063ef69e9',
    'https://firebasestorage.googleapis.com/v0/b/restaures-8e685.appspot.com/o/Banners%2Fx.png?alt=media&token=b9823e55-76bf-4a42-bec1-186c7c839fc9',
  ];
  List<RestaurantModel> restaurants = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getRestaurants();
  }

  getRestaurants() async {
    setState(() {
      _isLoading = true;
    });
    restaurants = await RestaurantService.getAllRestaurant();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomCarouselWidget(
            imageList: imageList,
          ),
          // list of restaurants

          _isLoading
              ? GFLoader()
              : restaurants.isEmpty
                  ? Center(
                      child: Text('No restaurant found'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RestaurantScreenUserView(
                                              restaurant: restaurants[index],
                                            )));

                                getRestaurants();
                              },
                              child: RestaurantCardWidget(
                                restaurant: restaurants[index],
                              )),
                        );
                      }),
        ],
      ),
    );
  }
}
