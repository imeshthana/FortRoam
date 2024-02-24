import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fort_roam/screens/favourites_screen.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/support_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
        onPageChanged: ((value) {
          setState(
            () {
              currentPage = value;
            },
          );
        }),
        children: [HomeScreen(), FavouritesScreen(), SupportScreen()],
      ),
      bottomNavigationBar: CurvedNavigationBar(
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
                milliseconds: 500,
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
            Icons.location_on,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}


          // BottomNavigationBarItem(
          //   icon: FaIcon(
          //     FontAwesomeIcons.houseChimneyMedical,
          //   ),
          //   label: 'Home',
          // ),
          // BottomNavigationBarItem(
          //   icon: FaIcon(
          //     FontAwesomeIcons.solidCalendarCheck,
          //   ),
          //   label: 'favourite',
          // ),
          // BottomNavigationBarItem(
          //   icon: FaIcon(
          //     FontAwesomeIcons.solidCalendarCheck,
          //   ),
          //   label: 'favourite',
          // ),