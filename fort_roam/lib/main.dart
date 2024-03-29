import 'package:flutter/material.dart';
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

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await MongoDatabase.connect();
  runApp(const FortRoamApp());
}

class FortRoamApp extends StatelessWidget {
  const FortRoamApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          // WelcomeScreen.id: (context) => MongoDbDisplay(),
          HomeScreen.id: (context) => HomeScreen(),
          HistoryScreen.id: (context) => HistoryScreen(),
          ActivityScreen.id: (context) => ActivityScreen(),
          SupportScreen.id: (context) => SupportScreen(),
          CommercialScreen.id: (context) => CommercialScreen(),
          FavouritesScreen.id: (context) => FavouritesScreen(),
          MainLayout.id: (context) => MainLayout(),
          MapScreen.id: (context) => MapScreen(),
          VoiceScreen.id: (context) => VoiceScreen(),
          AboutUsScreen.id: (context) => AboutUsScreen(),
        });
  }
}
