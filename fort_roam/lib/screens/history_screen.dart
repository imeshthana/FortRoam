import 'package:flutter/material.dart';
import 'package:fort_roam/components/card_items_container.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:fort_roam/components/search_bar.dart';
import 'package:fort_roam/components/sub_titles.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  static String id = 'history_screen';

  final Map<String, String> cardImages = {
    'images/1.jpg': 'xwedxecw',
    'images/2.jpg': 'ecewcewc',
    'images/3.jpg': 'edewccew',
    'images/4.jpg': 'xewxwxexw'
  };

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
              SubTitles(subTitle: 'Museums'),
              SizedBox(
                height: 20,
              ),
              CardItemsContainer(),
              SizedBox(
                height: 20,
              ),
              SubTitles(subTitle: "Bastians"),
              SizedBox(
                height: 20,
              ),
              CardItemsContainer(),
              SizedBox(
                height: 20,
              ),
              SubTitles(subTitle: "Others"),
              SizedBox(
                height: 20,
              ),
              CardItemsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
