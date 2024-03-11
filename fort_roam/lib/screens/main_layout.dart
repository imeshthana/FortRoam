import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fort_roam/screens/favourites_screen.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/map_screen.dart';
import 'package:fort_roam/screens/support_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
          VoiceScreen(),
          MapScreen()
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 500),
        index: currentPage,
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color.fromRGBO(226, 94, 62, 1),
        onTap: (page) {
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
        },
        items: const [
          Icon(
            Icons.home_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          Icon(
            Icons.mic,
            color: Colors.white,
          ),
          Icon(
            Icons.location_on,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

