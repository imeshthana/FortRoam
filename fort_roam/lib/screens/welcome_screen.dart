import 'package:flutter/material.dart';
import 'package:fort_roam/screens/home_screen.dart';
import 'package:fort_roam/screens/main_layout.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fort_roam/components/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;

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
            child: MainLayout(data:  widget.data),
            type: PageTransitionType.bottomToTop,
            duration: Duration(seconds: 2),
          ));
      // Navigator.pushNamed(context, MainLayout.id);
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
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  'images/cover.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.175),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('images/logo.png'),
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'FortRoam',
                style: TextStyle(
                  color: kColor1,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * 0.05,
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
              SizedBox(height: 10.0),
              Text(
                'Your go-to guide for a memorable stay',
                style: TextStyle(
                  color: Color.fromARGB(255, 79, 78, 78),
                  fontWeight: FontWeight.normal,
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.125),
              Visibility(
                visible: !showProgress,
                child: Material(
                  elevation: 5.0,
                  color: kColor1,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        showProgress = true;
                      });
                    },
                    minWidth: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: showProgress,
                child: CircularProgressIndicator(
                  color: kColor1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
