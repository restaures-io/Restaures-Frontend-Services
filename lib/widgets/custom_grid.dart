import 'package:flutter/material.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/widgets/custom_card.dart';

class MenuItemGridView extends StatelessWidget {
  const MenuItemGridView({
    super.key,
    required this.foodItems,
  });

  final List<MenuItem> foodItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          var item = foodItems[index];
          return MenuItemWidget(item: item);
        },
      ),
    );
  }
}
