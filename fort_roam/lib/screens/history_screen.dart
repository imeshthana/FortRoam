import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fort_roam/components/items_list.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/carousel_card_items.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:fort_roam/components/search_bar.dart';
import 'package:fort_roam/components/sub_titles.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  static String id = 'history_screen';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Center(child: CustomSearchBar()),
            SizedBox(height: 20.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubTitles(subTitle: 'Museums')),
            SizedBox(
              height: 20,
            ),
            CarouselCardItems(
              placeList: filterPlacesBySubtype('museum'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubTitles(subTitle: "Bastions")),
            SizedBox(
              height: 20,
            ),
            CarouselCardItems(
              placeList: filterPlacesBySubtype('bastion'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubTitles(subTitle: "Others")),
            SizedBox(
              height: 20,
            ),
            CarouselCardItems(
              placeList: filterPlacesBySubtype('others'),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
