import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/model/menu_page_mode.dart';
import 'package:restaures/model/restaurant.dart';
import 'package:restaures/pages/customer/restaurant_screen_user_view.dart';
import 'package:restaures/service/enquiry_service.dart';
import 'package:restaures/service/menu_service.dart';
import 'package:restaures/service/restaurant_service.dart';
import 'package:restaures/widgets/custom_card.dart';
import 'package:restaures/widgets/custom_carousel.dart';
import 'package:slider_button/slider_button.dart';
import 'package:toastification/toastification.dart';

class MenuItemView extends StatefulWidget {
  final String menuId;
  const MenuItemView({super.key, required this.menuId});

  @override
  State<MenuItemView> createState() => _MenuItemViewState();
}

class _MenuItemViewState extends State<MenuItemView> {
  bool _isLoading = false;

  late MenuPageModel menuPageModel;

  int quantity = 1;
  void getMenuById() async {
    // get menu items
    setState(() {
      _isLoading = true;
    });
    ApiResponse response = await MenuService.getMenuById(widget.menuId);
    if (response.success) {
      menuPageModel = MenuPageModel.fromJson(response.data);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getMenuById();
    super.initState();
  }

  List<RestaurantModel> restaurants = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SliderButton(
          width: double.infinity,
          action: () async {
            setState(() {
              _isLoading = true;
            });
            ApiResponse response = await EnquiryService.sendEnquiry(
                menuPageModel.id, quantity, quantity * menuPageModel.price);
            setState(() {
              _isLoading = false;
            });
            if (response.success) {
              toastification.show(
                title: Text(response.message),
                showIcon: true,
                type: ToastificationType.success,
                autoCloseDuration: const Duration(seconds: 5),
              );
              Navigator.pop(context);
            }
            return false;
          },
          label: Text(
            "Slide to send us your enquiry now!",
            style: TextStyle(
                color: Color(0xff4a4a4a),
                fontWeight: FontWeight.w500,
                fontSize: 17),
          ),
          icon: Icon(Icons.send_outlined, color: Colors.white),
          buttonColor: Colors.black,
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CustomCarouselWidget(imageList: menuPageModel.images),
                    SizedBox(
                      height: 10,
                    ),
                    // Item Name and description box with ratings and quantity counter
                    Container(
                      padding: const EdgeInsets.all(10),
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

                              // Restaurant Name
                              const SizedBox(
                                width: 10,
                              ),
                              TagWidget(
                                tagColor: Colors.black,
                                text: ' ETA ${menuPageModel.timeToPrepare}',
                                icon: Icons.timer_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TagWidget(
                                tagColor: Colors.white,
                                text: '${menuPageModel.price * quantity}',
                                icon: Icons.currency_rupee,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              // navigate to restaurant screen

                              RestaurantModel restaurant =
                                  await RestaurantService.getRestaurantById(
                                      menuPageModel.restaurantId.id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RestaurantScreenUserView(
                                              restaurant: restaurant)));
                            },
                            child: TagWidget(
                              tagColor: Colors.white,
                              text: menuPageModel.restaurantId.name,
                              icon: Icons.restaurant,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                menuPageModel.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),

                              const Spacer(),
                              // increment and decrement button
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                    child: Icon(Icons.remove),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            menuPageModel.description,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
