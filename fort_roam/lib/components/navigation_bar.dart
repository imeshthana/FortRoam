import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color.fromRGBO(226, 94, 62, 1),
        items: [
          Icon(
            Icons.home,
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
        onTap: (id) {
          if (id == 0) {
            Navigator.pushNamed(context, 'home_screen');
          } else if (id == 1) {
            Navigator.pushNamed(context, 'favourites_screen');
          } else if (id == 2) {
            Navigator.pushNamed(context, 'map_screen');
          }
          
        });
  }
}


