import 'package:flutter/material.dart';

class SubTitles extends StatelessWidget {
  const SubTitles({super.key, required this.subTitle});

  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(255, 252, 125, 93),
      ),
    );
  }
}
