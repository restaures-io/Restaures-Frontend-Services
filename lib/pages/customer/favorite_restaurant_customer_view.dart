import 'package:flutter/material.dart';
import 'package:restaures/model/restaurant.dart';
import 'package:restaures/service/restaurant_service.dart';
import 'package:restaures/widgets/custom_list.dart';

class FavoriteRestaurantCustomerPage extends StatefulWidget {
  @override
  _FavoriteRestaurantCustomerPageState createState() =>
      _FavoriteRestaurantCustomerPageState();
}

class _FavoriteRestaurantCustomerPageState
    extends State<FavoriteRestaurantCustomerPage> {
  List<RestaurantModel> restaurants = [];

  bool _isLoading = false;

  @override
  void initState() {
    getFavoriteRestaurants();
    super.initState();
  }

  void getFavoriteRestaurants() async {
    setState(() {
      _isLoading = true;
    });
    var response = await RestaurantService.getFavoriteRestaurants();
    if (response.success) {
      List data = response.data;
      restaurants = data.map((e) => RestaurantModel.fromJson(e)).toList();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurants'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : restaurants.isEmpty
              ? Center(child: Text('No favorite restaurant found'))
              : RestaurantListWidget(restaurants: restaurants),
    );
  }
}
