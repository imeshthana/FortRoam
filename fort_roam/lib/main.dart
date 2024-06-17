import 'package:flutter/material.dart';
import 'package:fort_roam/dbHelper/mongodb_model.dart';
import 'package:fort_roam/dbHelper/mongodb.dart';
import 'package:fort_roam/screens/about_us_screen.dart';
import 'package:fort_roam/screens/favourites_screen.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/main_layout.dart';
import 'package:fort_roam/screens/map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:fort_roam/screens/welcome_screen.dart';
import 'package:fort_roam/screens/history_screen.dart';
import 'package:fort_roam/screens/services_screen.dart';
import 'package:fort_roam/screens/activity_screen.dart';
import 'package:fort_roam/screens/commercial_screen.dart';
import 'package:fort_roam/screens/search_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('favBox');

  runApp(FortRoamApp());
}

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
