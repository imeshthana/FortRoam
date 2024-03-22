import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        height: MediaQuery.of(context).size.height * 0.35,
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
      ),
      items: sliderImages.map((String image) {
        return ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ));
      }).toList(),
    );
  }
}
