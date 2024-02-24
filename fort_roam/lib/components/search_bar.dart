import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 252, 125, 93),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.white,
            letterSpacing: 10.0,
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Colors.white,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
