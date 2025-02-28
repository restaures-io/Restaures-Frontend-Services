import 'package:flutter/material.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/service/menu_service.dart';

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
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  var item = foodItems[index];
                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            item.images![0],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name!,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                item.description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 11,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("₹${item.price}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange)),
                                  Text("${item.timeToPrepare} mins",
                                      style: TextStyle(color: Colors.grey[600]))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
