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
import 'package:fort_roam/screens/galle_fort_screen.dart';
import 'package:fort_roam/screens/history_screen.dart';
import 'package:fort_roam/screens/map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../components/search_bar.dart';
import '../components/navigation_bar.dart';
import '../components/section_icon_button.dart';
import '../components/slider.dart';
import 'package:fort_roam/components/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UniqueKey imageHeroTag = UniqueKey();
  final UniqueKey titleHeroTag = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            stretch: true,
            pinned: false,
            elevation: 0,
            centerTitle: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  CustomSlider(),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //       top: MediaQuery.of(context).size.height * 0.10),
                  //   width: double.infinity,
                  //   height: MediaQuery.of(context).size.height * 0.25,
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.bottomCenter,
                  //       end: Alignment.topCenter,
                  //       colors: [
                  //         Colors.white.withOpacity(1),
                  //         // Colors.transparent,
                  //         Colors.transparent,
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Hero(
                                tag: 'title',
                                child: Text(
                                  'FortRoam',
                                  style: TextStyle(
                                    color: kColor1,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.04,
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
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          SectionsRow(data: widget.data),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SubTitles(subTitle: 'Suggestions'),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                ItemsList(data: widget.data),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35)),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: Hero(
                                    tag: imageHeroTag,
                                    child: Image.asset(
                                      'images/placeImages/gallefort.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.10),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
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
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'Galle Fort',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.035,
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
                            child: Text(
                              'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
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
                                      child: GalleFortScreen(
                                        titleHeroTag: titleHeroTag,
                                        imageHeroTag: imageHeroTag,
                                      ),
                                      type: PageTransitionType.scale,
                                      alignment: Alignment.center,
                                      duration: Duration(milliseconds: 300),
                                    ));
                              },
                              minWidth: MediaQuery.of(context).size.width * 0.4,
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                              child: Text(
                                'Read More',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.035,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
