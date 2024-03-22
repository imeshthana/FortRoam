import 'package:flutter/material.dart';
import 'package:fort_roam/dbHelper/MongodbModel.dart';
import 'package:fort_roam/dbHelper/display.dart';
import 'package:fort_roam/dbHelper/mongodb.dart';
import 'package:fort_roam/screens/about_us_screen.dart';
import 'package:fort_roam/screens/favourites_screen.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/main_layout.dart';
import 'package:fort_roam/screens/map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:fort_roam/screens/welcome_screen.dart';
import 'package:fort_roam/screens/history_screen.dart';
import 'package:fort_roam/screens/support_screen.dart';
import 'package:fort_roam/screens/activity_screen.dart';
import 'package:fort_roam/screens/commercial_screen.dart';
import 'package:fort_roam/screens/voice_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('favBox');

  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  List<Map<String, dynamic>> data = await MongoDatabase.getData();
  runApp(FortRoamApp(data: data));
}

class FortRoamApp extends StatelessWidget {
  FortRoamApp({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(data: data),
          // WelcomeScreen.id: (context) => MongoDbDisplay(),
          HomeScreen.id: (context) => HomeScreen(data: data),
          HistoryScreen.id: (context) => HistoryScreen(data: data),
          ActivityScreen.id: (context) => ActivityScreen(data: data),
          SupportScreen.id: (context) => SupportScreen(),
          CommercialScreen.id: (context) => CommercialScreen(data: data),
          FavouritesScreen.id: (context) => FavouritesScreen(data: data,),
          MainLayout.id: (context) => MainLayout(data: data),
          MapScreen.id: (context) => MapScreen(data: data,),
          VoiceScreen.id: (context) => VoiceScreen(data: data,),
          AboutUsScreen.id: (context) => AboutUsScreen(),
        });
  }
}
