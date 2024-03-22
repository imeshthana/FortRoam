import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    Key? key,
     this.onSearch,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final Function(String)? onSearch;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: kColor2,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search',
          alignLabelWithHint: true,
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
