import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 30.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Hero(
              tag: 'title',
              child: Text(
                'FortRoam',
                style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
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
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 250.0,
                child: Image.asset(
                  'images/Cover1.jpg',
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
              Container(
                margin: EdgeInsets.only(top: 0.0),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.orange[700],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      letterSpacing: 10.0,
                    ),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.white,
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 10.0, // Set your desired elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set your desired border radius
                              ),
                              child: Container(
                                  width: 120,
                                  height: 80.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'images/1.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Historical Insights',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 10.0, // Set your desired elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set your desired border radius
                              ),
                              child: Container(
                                  width: 120,
                                  height: 80.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'images/2.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Local Delights',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 10.0, // Set your desired elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set your desired border radius
                              ),
                              child: Container(
                                  width: 120,
                                  height: 80.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'images/3.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Beyond History',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 10.0, // Set your desired elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set your desired border radius
                              ),
                              child: Container(
                                  width: 120,
                                  height: 80.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'images/4.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Support Center',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
