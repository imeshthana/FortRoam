import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/carousel_card_items.dart';
import 'package:fort_roam/components/sub_titles.dart';

class CommercialScreen extends StatelessWidget {
  const CommercialScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;
  static String id = 'commercial_screen';

  List<Map<String, dynamic>> filterPlacesBySubtype(String subtype) {
    return data.where((place) => place['subtype'] == subtype).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubTitles(subTitle: 'Hotels')),
            SizedBox(
              height: 20,
            ),
            CarouselCardItems(
              placeList: filterPlacesBySubtype('hotel'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubTitles(subTitle: "Resturants")),
            SizedBox(
              height: 20,
            ),
            CarouselCardItems(
              placeList: filterPlacesBySubtype('restaurant'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubTitles(subTitle: "Shops")),
            SizedBox(
              height: 20,
            ),
            CarouselCardItems(
              placeList: filterPlacesBySubtype('shop'),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
