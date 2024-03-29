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
            size: MediaQuery.of(context).size.height * 0.04,
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
              height: MediaQuery.of(context).size.height * 0.05,
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
                fontFamily: 'Round',
                color: Color.fromRGBO(255, 115, 0, 1),
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
