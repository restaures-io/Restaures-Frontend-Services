import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/model/restaurant.dart';
import 'package:restaures/service/menu_service.dart';
import 'package:restaures/service/restaurant_service.dart';
import 'package:restaures/utils/shared_prefrences.dart';
import 'package:restaures/widgets/custom_card.dart';
import 'package:restaures/widgets/custom_grid.dart';

class RestaurantScreenUserView extends StatefulWidget {
  const RestaurantScreenUserView({
    super.key,
    required this.restaurant,
  });

  final RestaurantModel restaurant;

  @override
  State<RestaurantScreenUserView> createState() =>
      _RestaurantScreenUserViewState();
}

class _RestaurantScreenUserViewState extends State<RestaurantScreenUserView> {
  Future<void> getRestaurantMenu() async {
    // get menu items
    ApiResponse response =
        await MenuService.getRestaurantMenu(widget.restaurant.id);
    if (response.success) {
      List<MenuItem> items = [];
      response.data.forEach((item) {
        items.add(MenuItem.fromJson(item));
      });
      setState(() {
        foodItems = items;
      });
    }
  }

  @override
  void initState() {
    initScreen();
    super.initState();
  }

  Future<void> initScreen() async {
    setState(() {
      _isLoading = true;
    });
    await getRestaurantMenu();
    await initLiked();

    setState(() {
      _isLoading = false;
    });
  }

  void postFavoriteRestaurant() async {
    ApiResponse response =
        await RestaurantService.putFavoriteRestaurant(widget.restaurant.id);
    if (response.success) {
      setState(() {
        widget.restaurant.favoriteBy
            .add(SharedPreferencesService.getString('user_id') ?? '');
      });
    }
  }

  void deleteFavoriteRestaurant() async {
    ApiResponse response =
        await RestaurantService.deleteFavoriteRestaurant(widget.restaurant.id);
    if (response.success) {
      setState(() {
        widget.restaurant.favoriteBy
            .remove(SharedPreferencesService.getString('user_id'));
      });
    }
  }

  Future<void> initLiked() async {
    String? user_id = SharedPreferencesService.getString('user_id');
    _isLiked = widget.restaurant.favoriteBy.contains(user_id);
  }

  List<MenuItem> foodItems = [];
  bool _isLiked = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    GFCarousel(
                        enlargeMainPage: true,
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        items: widget.restaurant.images.map(
                          (url) {
                            return Container(
                              margin: const EdgeInsets.all(2.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                child: Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            );
                          },
                        ).toList()),

                    // restaurant details
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const TagWidget(
                                tagColor: Colors.green,
                                text: '4.5',
                                icon: Icons.star,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const TagWidget(
                                tagColor: Colors.black,
                                text: '32m',
                                icon: Icons.timer_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const TagWidget(
                                tagColor: Colors.white,
                                text: '₹500/2',
                                icon: Icons.person_2_outlined,
                                color: Colors.black,
                              ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  _isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  if (_isLiked) {
                                    deleteFavoriteRestaurant();
                                  } else {
                                    postFavoriteRestaurant();
                                  }
                                  setState(() {
                                    _isLiked = !_isLiked;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.restaurant.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${widget.restaurant.location.address}, ${widget.restaurant.location.city}, ${widget.restaurant.location.state}, ${widget.restaurant.location.zipCode}, ${widget.restaurant.location.country}",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    // menu

                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Menu',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 0.1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuItemGridView(foodItems: foodItems)
                  ],
                ),
              ),
      ),
    );
  }
}
