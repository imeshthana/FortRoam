import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/items_list.dart';
import 'package:fort_roam/components/carousel_card_items.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:fort_roam/components/search_bar.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/components/constants.dart';

class CommercialScreen extends StatelessWidget {
  const CommercialScreen({super.key});
  static String id = 'commercial_screen';

  List<Map<String, String>> filterPlacesBySubtype(String subtype) {
    return places.where((place) => place['subtype'] == subtype).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Center(child: CustomSearchBar()),
              SizedBox(height: 20.0),
              SubTitles(subTitle: 'Hotels'),
              SizedBox(
                height: 20,
              ),
              CarouselCardItems(
                placeList: filterPlacesBySubtype('hotel'),
              ),
              SizedBox(
                height: 20,
              ),
              SubTitles(subTitle: "Resturants"),
              SizedBox(
                height: 20,
              ),
              CarouselCardItems(
                placeList: filterPlacesBySubtype('restaurant'),
              ),
              SizedBox(
                height: 20,
              ),
              SubTitles(subTitle: "Shops"),
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
      ),
    );
  }
}
