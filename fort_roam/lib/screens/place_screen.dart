import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:fort_roam/components/search_bar.dart';
import 'package:fort_roam/components/sub_titles.dart';

class PlaceScreen extends StatelessWidget {
  PlaceScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.imageHeroTag,
      required this.titleHeroTag});

  static String id = 'place_screen';

  final String image;
  final String title;
  final UniqueKey imageHeroTag;
  final UniqueKey titleHeroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.volume_up, color: Colors.white, size: 30.0),
        backgroundColor: Color.fromRGBO(226, 94, 62, 1),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      // appBar: CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 350.0,
                        child: Hero(
                          tag: imageHeroTag,
                          child: Image.asset(
                            image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.0),
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Hero(
                        tag: titleHeroTag, child: SubTitles(subTitle: title)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
