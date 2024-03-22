import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';

class Titles extends StatelessWidget {
  const Titles({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.035,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: kColor1,
      ),
    );
  }
}
