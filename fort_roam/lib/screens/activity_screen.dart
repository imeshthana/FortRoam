import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/items_grid.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:fort_roam/components/search_bar.dart';
import 'package:fort_roam/components/sub_titles.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({super.key, required this.data});
  static String id = 'activity_screen';

  final List<Map<String, dynamic>> data;

  List<Map<String, dynamic>> filterPlacesBySubtype() {
    return data.where((place) => place['subtype'] == 'activity').toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      appBar: CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                SubTitles(subTitle: 'Activities'),
                SizedBox(
                  height: 20,
                ),
                ItemsGrid(places: filterPlacesBySubtype()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

