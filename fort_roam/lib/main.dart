import 'package:flutter/material.dart';
import 'package:fort_roam/dbHelper/mongodb.dart';
import 'package:fort_roam/screens/favourites_screen.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/main_layout.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:fort_roam/screens/welcome_screen.dart';
import 'package:fort_roam/screens/history_screen.dart';
import 'package:fort_roam/screens/support_screen.dart';
import 'package:fort_roam/screens/activity_screen.dart';
import 'package:fort_roam/screens/commercial_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
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
          HomeScreen.id: (context) => HomeScreen(),
          HistoryScreen.id: (context) => HistoryScreen(),
          ActivityScreen.id: (context) => ActivityScreen(),
          SupportScreen.id: (context) => SupportScreen(),
          CommercialScreen.id: (context) => CommercialScreen(),
          PlaceScreen.id: (context) => PlaceScreen(),
          FavouritesScreen.id: (context) => FavouritesScreen(),
          MainLayout.id: (context) => MainLayout(),
        });
  }
}
