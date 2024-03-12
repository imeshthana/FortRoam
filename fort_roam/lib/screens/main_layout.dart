import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/screens/about_us_screen.dart';
import 'package:fort_roam/screens/favourites_screen.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/map_screen.dart';
import 'package:fort_roam/screens/support_screen.dart';
import 'package:fort_roam/screens/voice_screen.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key});

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
          Navigator.pushNamed(context, VoiceScreen.id);
        },
        child: Icon(
          FontAwesomeIcons.microphone,
          color: Colors.white,
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
          HomeScreen(),
          FavouritesScreen(),
          MapScreen(),
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
        _navigateToPage(index);
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
                      size: 25.0,
                    ),
                  ),
                )
              : Icon(
                  icon,
                  color: Colors.white,
                  size: 25.0,
                ),
          if (index == currentPage)
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
        ],
      ),
    );
  }

  String _getIconName(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Favourites';
      case 2:
        return 'Map';
      case 3:
        return 'About Us';
      default:
        return '';
    }
  }

  void _navigateToPage(int page) {
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
