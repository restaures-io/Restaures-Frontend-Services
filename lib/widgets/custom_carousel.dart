import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';

class CustomCarouselWidget extends StatelessWidget {
  const CustomCarouselWidget({
    super.key,
    required this.imageList,
  });

  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    return GFCarousel(
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 1),
        items: imageList.map(
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
        ).toList());
  }
}
