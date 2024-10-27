import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_card/image_card.dart';
import 'package:provider/provider.dart';
// import model
import 'package:restaures/models/home_screen_user/home_screen_user_model.dart';
// import controller
import 'package:restaures/controllers/home_screen_user/home_screen_user_controller.dart';
import 'package:restaures/views/User/restaurant_screen_user/restaurant_screen_user_view.dart';

class HomeScreenUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeScreenUserController viewController = HomeScreenUserController();
    return SingleChildScrollView(
      child: Column(
        children: [
          GFSearchBar(
              searchList: const [],
              overlaySearchListItemBuilder: (item) =>
                  GFListTile(titleText: item),
              searchQueryBuilder: (query, list) {
                return list
                    .where((item) => item.toLowerCase().contains(query))
                    .toList();
              },
              onItemSelected: (value) {}),
          GFCarousel(
              items: [
            'https://placehold.co/350x150.png',
            'https://placehold.co/350x150.png',
            'https://placehold.co/350x150.png',
          ].map(
            (url) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                ),
              );
            },
          ).toList()),

          // list of restaurants
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RestaurantScreenUserView()));
                    },
                    child: const TransparentImageCard(
                      height: 200,
                      width: double.infinity,
                      imageProvider:
                          NetworkImage('https://placehold.co/350x150.png'),
                      tags: [
                        // rating
                        TagWidget(
                          tagColor: Colors.green,
                          text: '4.5',
                          icon: Icons.star,
                          color: Colors.white,
                        ),
                        TagWidget(
                          tagColor: Colors.black,
                          text: '32m',
                          icon: Icons.timer_outlined,
                          color: Colors.white,
                        ),
                        TagWidget(
                          tagColor: Colors.white,
                          text: '₹500/2',
                          icon: Icons.person_2_outlined,
                          color: Colors.black,
                        )
                      ],
                      title: Text(
                        'Restaurant Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final Color tagColor;
  const TagWidget({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: tagColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
