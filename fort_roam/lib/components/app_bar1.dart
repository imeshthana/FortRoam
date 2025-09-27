import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.white,
      leading: null,
      title: Row(
        children: [
          Hero(
            tag: 'logo',
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Image.asset('images/logo.png'),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'FortRoam',
            style: TextStyle(
              fontFamily: 'Round',
              color: kColor1,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * 0.035,
              shadows: [
                BoxShadow(
                  color: const Color.fromARGB(255, 154, 147, 147),
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
