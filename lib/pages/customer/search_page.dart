import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/model/restaurant.dart';
import 'package:restaures/service/menu_service.dart';
import 'package:restaures/service/restaurant_service.dart';
import 'package:restaures/widgets/custom_grid.dart';
import 'package:restaures/widgets/custom_list.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<MenuItem> bigFoodItems = [], searchFoodItems = [];
  List<RestaurantModel> bigRestaurants = [], searchRestaurants = [];
  bool _isLoading = false;
  @override
  void initState() {
    initLists();
    super.initState();
  }

  Future<void> initLists() async {
    setState(() {
      _isLoading = true;
    });
    await getMenuItems();
    await getRestaurants();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getMenuItems() async {
    var response = await MenuService.getMenu();
    if (response.success) {
      List data = response.data;
      bigFoodItems = data.map((e) => MenuItem.fromJson(e)).toList();
    }
  }

  Future<void> getRestaurants() async {
    bigRestaurants = await RestaurantService.getAllRestaurant();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GFTextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (query) {
                        _onSearch(query);
                      },
                    ),
                  ),
                  const TabBar(
                    tabs: [
                      Tab(text: "Dishes"),
                      Tab(text: "Restaurants"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        MenuItemGridView(foodItems: searchFoodItems),
                        RestaurantListWidget(restaurants: searchRestaurants),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _onSearch(String query) {
    setState(() {
      _isLoading = true;
    });
    searchFoodItems = bigFoodItems
        .where((element) =>
            element.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    searchRestaurants = bigRestaurants
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (query.isEmpty) {
      searchFoodItems = [];
      searchRestaurants = [];
    }
    setState(() {
      _isLoading = false;
    });
  }
}
