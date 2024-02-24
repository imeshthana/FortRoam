// import 'package:flutter/material.dart';
// import 'package:fort_roam/components/gesture_card.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//   static String id = 'home_screen';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       bottomNavigationBar: CurvedNavigationBar(
//           height: 60,
//           backgroundColor: Colors.transparent,
//           color: Color.fromRGBO(239, 108, 0, 1),
//           items: [
//             Icon(
//               Icons.home,
//               color: Colors.white,
//             ),
//             Icon(Icons.favorite, color: Colors.white,),
//             Icon(Icons.location_on, color: Colors.white,)
//           ]),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: null,
//         title: Row(
//           children: [
//             Hero(
//               tag: 'logo',
//               child: Container(
//                 height: 30.0,
//                 child: Image.asset('images/logo.png'),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Hero(
//               tag: 'title',
//               child: Text(
//                 'FortRoam',
//                 style: TextStyle(
//                   color: Color.fromRGBO(239, 108, 0, 1),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25,
//                   shadows: [
//                     BoxShadow(
//                       color: const Color.fromARGB(255, 154, 147, 147),
//                       offset: Offset(2.0, 2.0),
//                       blurRadius: 3.0,
//                       spreadRadius: 1.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 250.0,
//                   child: Image.asset(
//                     'images/Cover1.jpg',
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 100.0),
//                   width: double.infinity,
//                   height: 150.0,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                       colors: [
//                         Colors.white.withOpacity(1),
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 0.0),
//                   width: double.infinity,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.white.withOpacity(1),
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // SizedBox(height: 20.0),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 220.0,
//                   margin: EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     color: Colors.orange[700],
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   child: TextField(
//                     textAlign: TextAlign.center,
//                     keyboardType: TextInputType.text,
//                     onChanged: (value) {},
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       hintStyle: TextStyle(
//                         color: Colors.white,
//                         letterSpacing: 10.0,
//                       ),
//                       prefixIcon: Icon(Icons.search),
//                       prefixIconColor: Colors.white,
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 Column(
//                   children: [
//                     Row(
//                       children: [
//                         GestureCard(
//                           image: 'images/1.jpg',
//                           name: 'Historical Insights',
//                           onTap: (){
//                             Navigator.pushNamed(context, 'history_screen');
//                           },
//                         ),
//                         GestureCard(
//                           image: 'images/2.jpg',
//                           name: 'Local Delights',
//                           onTap: (){
//                             Navigator.pushNamed(context, 'local_screen');
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         GestureCard(
//                           name: 'Beyond History',
//                           image: 'images/3.jpg',
//                           onTap: (){
//                             Navigator.pushNamed(context, 'activities_screen');
//                           },
//                         ),
//                         GestureCard(
//                           name: 'Support Center',
//                           image: 'images/4.jpg',
//                           onTap: (){
//                             Navigator.pushNamed(context, 'support_screen');
//                           },
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(35),
//                       bottomRight: Radius.circular(35)),
//                   child: Stack(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 250.0,
//                         child: Image.asset(
//                           'images/gallefort.jpg',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 0.0),
//                         width: double.infinity,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.white.withOpacity(1),
//                               Colors.transparent,
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 Container(
//                   alignment: Alignment.bottomCenter,
//                   child: Text(
//                     'Galle Fort',
//                     style: TextStyle(
//                       fontSize: 25.0,
//                       fontWeight: FontWeight.bold,
//                       fontStyle: FontStyle.italic,
//                       color: Colors.orange[700],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20.0),
//                   padding: EdgeInsets.all(10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: null,
//                   ),
//                   child: Text(
//                     'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Material(
//                   elevation: 5.0,
//                   color: Colors.orange[800],
//                   borderRadius: BorderRadius.circular(30.0),
//                   child: MaterialButton(
//                     onPressed: () {},
//                     minWidth: 150.0,
//                     height: 40.0,
//                     child: Text(
//                       'Read More',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fort_roam/components/card_items_container.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/sub_titles.dart';
import '../components/search_bar.dart';
import '../components/navigation_bar.dart';
import '../components/section_icon_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static String id = 'home_screen';

  final List<String> sliderImages = [
    'images/slider1.jpg',
    'images/slider2.jpg',
    'images/slider3.png',
  ];

  List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.syringe,
      "category": "History",
    },
    {
      "icon": FontAwesomeIcons.heartPulse,
      "category": "Commercial",
    },
    {
      "icon": FontAwesomeIcons.lungs,
      "category": "Activities",
    },
    {
      "icon": FontAwesomeIcons.hand,
      "category": "Support",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                  ),
                  items: sliderImages.map((String image) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
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
                  margin: EdgeInsets.only(top: 235),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSearchBar(),
                      SizedBox(height: 40.0),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(children: [
                          SectionIconButton(
                            route: 'history_screen',
                            icon: Icons.account_balance,
                            section: 'Historical',
                          ),
                          SectionIconButton(
                            route: 'commercial_screen',
                            icon: Icons.restaurant,
                            section: 'Local',
                          ),
                          SectionIconButton(
                            route: 'activity_screen',
                            icon: Icons.directions_run,
                            section: 'Activity',
                          ),
                          SectionIconButton(
                            route: 'support_screen',
                            icon: Icons.safety_check,
                            section: 'Support',
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubTitles(subTitle: 'Your Recommendations'),
                            SizedBox(height: 20.0),
                            CardItemsContainer(),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 250.0,
                              child: Image.asset(
                                'images/gallefort.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 100.0),
                              width: double.infinity,
                              height: 150,
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
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Galle Fort',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(255, 252, 125, 93),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: null,
                        ),
                        child: Text(
                          'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        elevation: 5.0,
                        color: const Color.fromRGBO(226, 94, 62, 1),
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'place_screen');
                          },
                          minWidth: 150.0,
                          height: 40.0,
                          child: Text(
                            'Read More',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
