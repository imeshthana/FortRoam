import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar1.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/items_grid.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:fort_roam/components/search_bar.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/dbHelper/fav_places.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  static String id = 'favourites_screen';

  // final List<Map<String, String>> favouritePlaces = [
  //   {
  //     'image': 'images/1.jpg',
  //     'title': 'Lighthouse',
  //   },
  //   {
  //     'image': 'images/2.jpg',
  //     'title': 'Jewelleries',
  //   },
  //   {
  //     'image': 'images/3.jpg',
  //     'title': 'Fort Jump',
  //   },
  //   {
  //     'image': 'images/4.jpg',
  //     'title': 'Museum',
  //   }
  // ];

  final FavPlaces db = FavPlaces();

  @override
  Widget build(BuildContext context) {
    List<String> favoritePlaces = db.getFavoritePlaces();

    List<Map<String, dynamic>> filteredPlaces =
        data.where((place) => favoritePlaces.contains(place['title'])).toList();

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
                SubTitles(subTitle: 'Favourites'),
                SizedBox(
                  height: 20,
                ),
                ItemsGrid(places: filteredPlaces)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
