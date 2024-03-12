import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fort_roam/components/items_list.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/sections_row.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/screens/activity_screen.dart';
import 'package:fort_roam/screens/commercial_screen.dart';
import 'package:fort_roam/screens/history_screen.dart';
import 'package:fort_roam/screens/map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../components/search_bar.dart';
import '../components/navigation_bar.dart';
import '../components/section_icon_button.dart';
import '../components/slider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UniqueKey imageHeroTag = UniqueKey();
  final UniqueKey titleHeroTag = UniqueKey();

  static String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      body: Stack(
        children: [
          CustomSlider(),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100.0),
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white.withOpacity(1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CustomSearchBar(),
                        // Text(
                        //   'Welcome to,',
                        //   style: TextStyle(color: Colors.grey, fontSize: 15),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'logo',
                              child: Container(
                                  child: Image.asset('images/logo.png'),
                                  height: 35.0),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Hero(
                              tag: 'title',
                              child: Text(
                                'FortRoam',
                                style: TextStyle(
                                  color: Colors.orange[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  shadows: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                          255, 154, 147, 147),
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.0),
                        SectionsRow(),
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubTitles(subTitle: 'Suggestions'),
                              SizedBox(height: 20.0),
                              ItemsList(),
                            ],
                          ),
                        ),
                        SizedBox(height: 70.0),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35)),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 250.0,
                                child: Hero(
                                  tag: imageHeroTag,
                                  child: Image.asset(
                                    'images/placeImages/gallefort.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 100.0),
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
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
                        SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Galle Fort',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 252, 125, 93),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: null,
                          ),
                          child: Text(
                            'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Material(
                          elevation: 5.0,
                          color: const Color.fromRGBO(226, 94, 62, 1),
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    child: PlaceScreen(
                                      image: 'images/placeImages/gallefort.jpg',
                                      title: 'Galle Fort',
                                      titleHeroTag: titleHeroTag,
                                      imageHeroTag: imageHeroTag,
                                    ),
                                    type: PageTransitionType.scale,
                                    alignment: Alignment.center,
                                    duration: Duration(milliseconds: 300),
                                  ));
                            },
                            minWidth: 150.0,
                            height: 40.0,
                            child: Text(
                              'Read More',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
