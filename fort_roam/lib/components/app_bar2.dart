import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.home_rounded,
            color: const Color.fromRGBO(226, 94, 62, 1),
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      automaticallyImplyLeading: false,
      leading: null,
      title: Row(
        children: [
          Hero(
            tag: 'logo',
            child: Container(
              height: 30.0,
              child: Image.asset('images/logo.png'),
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
                color: Color.fromRGBO(239, 108, 0, 1),
                fontWeight: FontWeight.bold,
                fontSize: 25,
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
