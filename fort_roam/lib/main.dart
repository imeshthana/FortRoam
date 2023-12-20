import 'package:flutter/material.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/welcome_screen.dart';

void main() {
  runApp(const FortRoamApp());
}

class FortRoamApp extends StatelessWidget {
  const FortRoamApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomeScreen.id: (context) => HomeScreen(),
        });
  }
}