import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/model/restaurant.dart';
import 'package:restaures/pages/customer/menu_item_view.dart';

class RestaurantCardWidget extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantCardWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return TransparentImageCard(
      height: 200,
      width: double.infinity,
      imageProvider: NetworkImage(restaurant.images[0]),
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
        restaurant.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
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

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    super.key,
    required this.item,
  });

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MenuItemView(menuId: item.id ?? ""),
        ),
      ),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
