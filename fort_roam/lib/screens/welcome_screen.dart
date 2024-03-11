import 'package:flutter/material.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/main_layout.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool showProgress = false;

  @override
  void initState() {
    setState(() {
      showProgress = false;
    });

    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context,
          PageTransition(
            child: MainLayout(),
            type: PageTransitionType.bottomToTop,
            duration: Duration(seconds: 2),
          ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 250.0,
                child: Image.asset(
                  'images/cover.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100.0),
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white.withOpacity(1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 120.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                    child: Image.asset('images/logo.png'), height: 75.0),
              ),
              SizedBox(
                height: 20,
              ),
              Hero(
                tag: 'title',
                child: Text(
                  'FortRoam',
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    shadows: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 154, 147, 147),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Your go-to guide for a memorable stay',
                style: TextStyle(
                  color: Color.fromARGB(255, 79, 78, 78),
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 100.0),
              Visibility(
                visible: !showProgress,
                child: Material(
                  elevation: 5.0,
                  color: const Color.fromRGBO(226, 94, 62, 1),
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        showProgress = true;
                      });
                    },
                    minWidth: 200.0,
                    height: 50.0,
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: showProgress,
                child: CircularProgressIndicator(
                  color: const Color.fromRGBO(226, 94, 62, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
