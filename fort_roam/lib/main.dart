import 'package:flutter/material.dart';
import 'package:fort_roam/screens/welcome_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter();

  runApp(FortRoamApp());
}

// ignore: must_be_immutable
class FortRoamApp extends StatelessWidget {
  FortRoamApp({super.key});

  // final List<Map<String, dynamic>> data;
  bool hasInternet = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
