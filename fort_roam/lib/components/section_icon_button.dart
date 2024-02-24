import 'package:flutter/material.dart';

class SectionIconButton extends StatelessWidget {
  SectionIconButton(
      {required this.icon, required this.route, required this.section});

  final String section;
  final String route;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          children: [
            Material(
              elevation: 10.0,
              shape: CircleBorder(),
              color: const Color.fromRGBO(226, 94, 62, 1),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              section,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
