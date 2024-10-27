import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/restaurant_screen_user/restaurant_screen_user_model.dart';
// import controller
import 'package:restaures/controllers/restaurant_screen_user/restaurant_screen_user_controller.dart';
import 'package:restaures/views/User/home_screen_user/home_screen_user_view.dart';

class RestaurantScreenUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RestaurantScreenUserController viewController =
        RestaurantScreenUserController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              GFCarousel(
                  enlargeMainPage: true,
                  items: [
                    'https://placehold.co/350x150.png',
                    'https://placehold.co/350x150.png',
                    'https://placehold.co/350x150.png',
                  ].map(
                    (url) {
                      return Container(
                        margin: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
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
              Card(
                  elevation: 3,
                  borderOnForeground: true,
                  child: Padding(
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
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Restaurant Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )),

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
              Container(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 300,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
