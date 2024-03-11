import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  CustomSlider({
    super.key,
  });

  final List<String> sliderImages = [
    'images/slider1.jpg',
    'images/slider2.jpg',
    'images/slider3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0,
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
      ),
      items: sliderImages.map((String image) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}
