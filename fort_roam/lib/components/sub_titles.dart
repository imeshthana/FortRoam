import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';

class SubTitles extends StatelessWidget {
  const SubTitles({super.key, required this.subTitle});

  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.025,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: kColor2,
      ),
    );
  }
}
