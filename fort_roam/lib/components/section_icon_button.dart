import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:page_transition/page_transition.dart';

class SectionIconButton extends StatelessWidget {
  SectionIconButton(
      {required this.icon, required this.route, required this.section});

  final String section;
  final Widget route;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  child: route,
                  type: PageTransitionType.bottomToTop,
                  duration: Duration(milliseconds: 500),
                  reverseDuration: Duration(milliseconds: 500)));
        },
        child: Column(
          children: [
            Material(
              elevation: 10.0,
              shape: CircleBorder(),
              color: kColor1,
              child: Padding(
                padding: const EdgeInsets.all(12.5),
                child: Icon(
                  icon,
                  size: MediaQuery.of(context).size.height * 0.030,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              section,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.height * 0.02),
            ),
          ],
        ),
      ),
    );
  }
}
