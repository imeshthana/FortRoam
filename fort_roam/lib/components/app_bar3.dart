import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  List<String> instructions = [
    "Try best route to save your time and energy.",
    "Use custom route to navigate through your customized route.",
    "Drag and swap the places to customize your route.",
    "Slide the card to delete the place from favourites.",
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: IconButton(
              icon: Icon(
                Icons.info,
                color: kColor1,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: Center(
                          child: Text(
                        "Instructions",
                        style: TextStyle(
                            color: kColor1,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025),
                      )),
                      // actions: [
                      //   Positioned(
                      //     top: 0,
                      //     right: 0,
                      //     child: IconButton(
                      //       icon: Icon(
                      //         Icons.close,
                      //         color: kColor1,
                      //       ),
                      //       onPressed: () {
                      //         Navigator.of(context).pop();
                      //       },
                      //     ),
                      //   ),
                      // ],
                      content: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: instructions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.arrow_right,
                                    color: kColor1,
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      instructions[index],
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
        )
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
