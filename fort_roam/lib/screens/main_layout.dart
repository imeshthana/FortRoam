import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/screens/about_us_screen.dart';
import 'package:fort_roam/screens/favourites_screen.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/search_screen.dart';
import 'package:fort_roam/screens/map_screen.dart';
import 'package:fort_roam/screens/services_screen.dart';
import 'package:fort_roam/screens/search_screen.dart';
import 'package:page_transition/page_transition.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key, required this.data});

  final List<Map<String, dynamic>> data;
  static String id = 'main_layout';

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: VoiceScreen(data: widget.data),
                  type: PageTransitionType.bottomToTop,
                  duration: Duration(milliseconds: 500),
                  reverseDuration: Duration(milliseconds: 500)));
        },
        child: Icon(
          FontAwesomeIcons.searchLocation,
          color: Colors.white,
          size: MediaQuery.of(context).size.height * 0.035,
        ),
        backgroundColor: kColor1,
      ),
      body: PageView(
        controller: _page,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: ((value) {
          setState(
            () {
              currentPage = value;
            },
          );
        }),
        children: [
          HomeScreen(data: widget.data),
          FavouritesScreen(
            data: widget.data,
          ),
          MapScreen(
            data: widget.data,
          ),
          AboutUsScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 60,
        shape: CircularNotchedRectangle(),
        color: kColor1,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(Icons.home_rounded, 'Home', 0),
            buildNavItem(Icons.favorite, 'Favorites', 1),
            SizedBox(
              width: 30,
            ),
            buildNavItem(Icons.location_on, 'Map', 2),
            buildNavItem(Icons.info, 'About Us', 3),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        navigateToPage(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          index == currentPage
              ? Material(
                  // elevation: 10.0,
                  color: kColor2,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.height * 0.035,
                    ),
                  ),
                )
              : Icon(
                  icon,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.035,
                ),
          if (index == currentPage)
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.0175,
              ),
            ),
        ],
      ),
    );
  }

  void navigateToPage(int page) {
    setState(() {
      currentPage = page;
      _page.animateToPage(
        page,
        duration: const Duration(
          milliseconds: 1000,
        ),
        curve: Curves.easeInOut,
      );
    });
  }
}
