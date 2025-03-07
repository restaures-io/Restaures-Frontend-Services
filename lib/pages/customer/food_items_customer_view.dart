import 'package:flutter/material.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/service/menu_service.dart';
import 'package:restaures/widgets/custom_card.dart';
import 'package:restaures/widgets/custom_grid.dart';

class FoodItemCustomerPage extends StatefulWidget {
  @override
  _FoodItemCustomerPageState createState() => _FoodItemCustomerPageState();
}

class _FoodItemCustomerPageState extends State<FoodItemCustomerPage> {
  List<MenuItem> foodItems = [];

  bool _isLoading = false;

  @override
  void initState() {
    getMenuItems();
    super.initState();
  }

  void getMenuItems() async {
    setState(() {
      _isLoading = true;
    });
    var response = await MenuService.getMenu();
    if (response.success) {
      List data = response.data;
      foodItems = data.map((e) => MenuItem.fromJson(e)).toList();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : MenuItemGridView(foodItems: foodItems),
    );
  }
}
