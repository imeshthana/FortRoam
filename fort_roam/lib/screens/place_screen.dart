// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:fort_roam/components/app_bar2.dart';
// import 'package:fort_roam/components/constants.dart';
// import 'package:fort_roam/components/gesture_card.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:fort_roam/components/navigation_bar.dart';
// import 'package:fort_roam/components/search_bar.dart';
// import 'package:fort_roam/components/review_list.dart';
// import 'package:fort_roam/components/sub_titles.dart';
// import 'package:fort_roam/components/titles.dart';
// import 'package:fort_roam/dbHelper/MongodbModel.dart';
// import 'package:fort_roam/dbHelper/fav_places.dart';
// import 'package:fort_roam/dbHelper/mongodb.dart';
// import 'package:fort_roam/screens/map_screen.dart';
// import 'package:hive/hive.dart';
// import 'package:page_transition/page_transition.dart';

// class PlaceScreen extends StatefulWidget {
//   PlaceScreen(
//       {super.key,
//       required this.image,
//       required this.title,
//       required this.imageHeroTag,
//       required this.titleHeroTag,
//       required this.onShowPlaceOnMap,
//       required this.data});

//   static String id = 'place_screen';

//   final String image;
//   final String title;
//   final UniqueKey imageHeroTag;
//   final UniqueKey titleHeroTag;
//   final bool onShowPlaceOnMap;
//   final List<Map<String, dynamic>> data;

//   @override
//   State<PlaceScreen> createState() => _PlaceScreenState();
// }

// class _PlaceScreenState extends State<PlaceScreen>
//     with TickerProviderStateMixin {
//   late Map<String, dynamic> selectedPlace;
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController reviewController = TextEditingController();
//   double rating = 0;

//   FavPlaces db = FavPlaces();

//   final favBox = Hive.openBox('favBox');

//   late bool isFavorite;

//   getPlace() {
//     selectedPlace =
//         widget.data.firstWhere((place) => place['title'] == widget.title);
//   }

//   ValueNotifier<double> offsetNotifier = ValueNotifier(0);
//   final PageController pageController = PageController();

//   @override
//   void initState() {
//     super.initState();

//     getPlace();
//     isFavorite = db.getFavoritePlaces().contains(widget.title);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Container(
//         margin: EdgeInsets.only(bottom: 15, right: 5),
//         child: FloatingActionButton(
//           onPressed: () {},
//           child: Icon(Icons.volume_up, color: Colors.white, size: 30.0),
//           backgroundColor: kColor1,
//           elevation: 5,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//         ),
//       ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
//       // floatingActionButton: widget.onShowPlaceOnMap == true
//       //     ? Column(
//       //         children: [
//       //           Container(
//       //             margin: EdgeInsets.only(top: 10, right: 0),
//       //             child: FloatingActionButton(
//       //               // mini: true,
//       //               onPressed: () {
//       //                 setState(() {
//       //                   isFavorite = !isFavorite;
//       //                   if (isFavorite) {
//       //                     db.addFavoritePlace(widget.title);
//       //                   } else {
//       //                     db.removeFavoritePlace(widget.title);
//       //                   }
//       //                 });
//       //               },
//       //               child: Icon(
//       //                 isFavorite ? Icons.favorite : Icons.favorite_border,
//       //                 color: isFavorite ? kColor1 : Colors.white,
//       //                 size: 40.0,
//       //               ),
//       //               backgroundColor: Colors.transparent,
//       //               elevation: 0,
//       //               shape: RoundedRectangleBorder(
//       //                 borderRadius: BorderRadius.circular(100),
//       //               ),
//       //             ),
//       //           ),
//       //           Spacer(),
//       //           Container(
//       //             margin: EdgeInsets.only(bottom: 60, right: 10),
//       //             child: FloatingActionButton(
//       //               onPressed: () {
//       //                 Navigator.push(
//       //                     context,
//       //                     PageTransition(
//       //                         child: MapScreen(
//       //                           title: widget.title,
//       //                           data: widget.data,
//       //                         ),
//       //                         type: PageTransitionType.bottomToTop,
//       //                         duration: Duration(milliseconds: 500),
//       //                         reverseDuration: Duration(milliseconds: 500)));
//       //               },
//       //               child: Icon(Icons.location_on,
//       //                   color: Colors.white, size: 30.0),
//       //               backgroundColor: kColor1,
//       //               elevation: 5,
//       //               shape: RoundedRectangleBorder(
//       //                 borderRadius: BorderRadius.circular(20.0),
//       //               ),
//       //             ),
//       //           ),
//       //         ],
//       //       )
//       //     : null,
//       backgroundColor: Colors.white,
//       // bottomNavigationBar: CustomNavigationBar(),
//       // appBar: CustomAppBar(),
//       body: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20)),
//             child: Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 350.0,
//                   child: Hero(
//                     tag: widget.imageHeroTag,
//                     child: Image.asset(
//                       widget.image,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 0.0),
//                   width: double.infinity,
//                   height: 150,
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
//           ),
//           SingleChildScrollView(
//             child: Stack(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 350),
//                   color: Colors.white,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Center(
//                           child: Hero(
//                               tag: widget.titleHeroTag,
//                               child: Titles(title: widget.title))),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Column(children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(103, 168, 168, 168),
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               padding: EdgeInsets.only(
//                                   top: 6, left: 15, right: 15, bottom: 6),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text('3.8',
//                                       style: TextStyle(
//                                         fontSize: 30.0,
//                                         fontWeight: FontWeight.bold,
//                                       )),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Column(
//                                     children: [
//                                       RatingBarIndicator(
//                                         rating: 3.8,
//                                         itemSize: 20,
//                                         itemBuilder: (context, _) => Icon(
//                                           Icons.star,
//                                           color: kColor1,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text('Overall Rating',
//                                           style: TextStyle(
//                                             fontSize: 10.0,
//                                             fontWeight: FontWeight.w400,
//                                           )),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(103, 168, 168, 168),
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               child: IconButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       PageTransition(
//                                           child: MapScreen(
//                                             title: widget.title,
//                                             data: widget.data,
//                                           ),
//                                           type: PageTransitionType.bottomToTop,
//                                           duration: Duration(milliseconds: 500),
//                                           reverseDuration:
//                                               Duration(milliseconds: 500)));
//                                 },
//                                 color: Colors.grey[300],
//                                 // shape: CircleBorder(),
//                                 // padding: EdgeInsets.all(12),
//                                 icon: Icon(
//                                   Icons.directions,
//                                   color: kColor1,
//                                   size: 30,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(103, 168, 168, 168),
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               child: IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     isFavorite = !isFavorite;
//                                     if (isFavorite) {
//                                       db.addFavoritePlace(widget.title);
//                                     } else {
//                                       db.removeFavoritePlace(widget.title);
//                                     }
//                                   });
//                                 },
//                                 color: Colors.grey[300],
//                                 // shape: CircleBorder(),
//                                 // padding: EdgeInsets.all(12),
//                                 icon: Icon(
//                                   isFavorite
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: kColor1,
//                                   size: 30.0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ]),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 20.0),
//                         padding: EdgeInsets.all(10.0),
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               SubTitles(subTitle: 'Description'),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Container(
//                                 child: Text(
//                                   'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture.',
//                                   // textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize:
//                                         MediaQuery.of(context).size.height *
//                                             0.02,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 30,
//                               ),
//                               SubTitles(subTitle: 'Reviews and Ratings'),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               ReviewList(),
//                               SizedBox(
//                                 height: 30,
//                               ),
//                               SubTitles(subTitle: 'Add Your Review'),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Form(
//                                 child: Column(
//                                   children: [
//                                     TextFormField(
//                                       controller: nameController,
//                                       decoration: InputDecoration(
//                                         labelText: 'Name',
//                                         labelStyle:
//                                             TextStyle(color: Colors.grey),
//                                         filled: true,
//                                         fillColor: Colors.grey[200],
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                           borderSide: BorderSide(
//                                               width: 2, color: kColor3),
//                                         ),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                           borderSide: BorderSide(
//                                               width: 2, color: Colors.grey),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 15),
//                                     TextFormField(
//                                       controller: reviewController,
//                                       decoration: InputDecoration(
//                                         labelText: 'Review',
//                                         labelStyle:
//                                             TextStyle(color: Colors.grey),
//                                         filled: true,
//                                         fillColor: Colors.grey[200],
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                           borderSide: BorderSide(
//                                             color: kColor3,
//                                             width: 2,
//                                           ),
//                                         ),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                           borderSide: BorderSide(
//                                             color: Colors.grey,
//                                             width: 2,
//                                           ),
//                                         ),
//                                       ),
//                                       maxLines: 3,
//                                     ),
//                                     SizedBox(height: 15),
//                                     RatingBar.builder(
//                                       initialRating: rating,
//                                       minRating: 1,
//                                       direction: Axis.horizontal,
//                                       allowHalfRating: false,
//                                       itemCount: 5,
//                                       itemSize: 30.0,
//                                       itemBuilder: (context, _) => Icon(
//                                         Icons.star,
//                                         color: kColor1,
//                                       ),
//                                       onRatingUpdate: (newRating) {
//                                         setState(() {
//                                           rating = newRating;
//                                         });
//                                       },
//                                     ),
//                                     SizedBox(height: 15),
//                                     Material(
//                                       elevation: 5.0,
//                                       color: kColor1,
//                                       borderRadius: BorderRadius.circular(30.0),
//                                       child: MaterialButton(
//                                         onPressed: () {},
//                                         minWidth:
//                                             MediaQuery.of(context).size.width *
//                                                 0.35,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.05,
//                                         child: Text(
//                                           'Submit',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.02,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ]),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void submitReview() async {
//     if (nameController.text.isNotEmpty && reviewController.text.isNotEmpty) {
//       Map<String, dynamic> newReview = {
//         'name': nameController.text,
//         'content': reviewController.text,
//         'rating': rating,
//       };

//       setState(() {
//         selectedPlace['reviews'].add(newReview);
//       });

//       nameController.clear();
//       reviewController.clear();
//       setState(() {
//         rating = 0;
//       });

//       await MongoDatabase.addReview(selectedPlace['title'], newReview);
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:fort_roam/components/search_bar.dart';
import 'package:fort_roam/components/review_list.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/components/titles.dart';
import 'package:fort_roam/dbHelper/MongodbModel.dart';
import 'package:fort_roam/dbHelper/fav_places.dart';
import 'package:fort_roam/dbHelper/mongodb.dart';
import 'package:fort_roam/screens/map_screen.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

class PlaceScreen extends StatefulWidget {
  PlaceScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.imageHeroTag,
      required this.titleHeroTag,
      required this.onShowPlaceOnMap,
      required this.data});

  static String id = 'place_screen';

  final String image;
  final String title;
  final UniqueKey imageHeroTag;
  final UniqueKey titleHeroTag;
  final bool onShowPlaceOnMap;
  final List<Map<String, dynamic>> data;

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  late Map<String, dynamic> selectedPlace;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  double rating = 0;

  FavPlaces db = FavPlaces();

  final favBox = Hive.openBox('favBox');

  late bool isFavorite;

  getPlace() {
    selectedPlace =
        widget.data.firstWhere((place) => place['title'] == widget.title);
  }

  @override
  void initState() {
    super.initState();

    getPlace();
    isFavorite = db.getFavoritePlaces().contains(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 15, right: 5),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.volume_up,
            color: Colors.white,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
          backgroundColor: kColor1,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      // appBar: CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            stretch: true,
            pinned: false,
            elevation: 0,
            centerTitle: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.45,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.blurBackground],
              background: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Hero(
                        tag: widget.imageHeroTag,
                        child: Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0.0),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0,
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
              ),
            ),
          ),
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 0,
            // expandedHeight: 100,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.075,
              ),
              child: SizedBox(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.045,
                ),
                Center(
                    child: Hero(
                        tag: widget.titleHeroTag,
                        child: Titles(title: widget.title))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(103, 168, 168, 168),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0075,
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.0075,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('3.8',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.04,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                RatingBarIndicator(
                                  rating: 3.8,
                                  itemSize: MediaQuery.of(context).size.height *
                                      0.025,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: kColor1,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Overall Rating',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(103, 168, 168, 168),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: MapScreen(
                                      title: widget.title,
                                      data: widget.data,
                                    ),
                                    type: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 500),
                                    reverseDuration:
                                        Duration(milliseconds: 500)));
                          },
                          color: Colors.grey[300],
                          // shape: CircleBorder(),
                          // padding: EdgeInsets.all(12),
                          icon: Icon(
                            Icons.directions,
                            color: kColor1,
                            size: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(103, 168, 168, 168),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                              if (isFavorite) {
                                db.addFavoritePlace(widget.title);
                              } else {
                                db.removeFavoritePlace(widget.title);
                              }
                            });
                          },
                          color: Colors.grey[300],
                          // shape: CircleBorder(),
                          // padding: EdgeInsets.all(12),
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: kColor1,
                            size: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Container(
                // margin: EdgeInsets.only(top: 350),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.02,
                      ),
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SubTitles(subTitle: 'Description'),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Container(
                              child: Text(
                                'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture.',
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            SubTitles(subTitle: 'Reviews and Ratings'),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                            ReviewList(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            SubTitles(subTitle: 'Add Your Review'),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                            Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                            width: 2, color: kColor3),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    controller: reviewController,
                                    decoration: InputDecoration(
                                      labelText: 'Review',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          color: kColor3,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    maxLines: 3,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  RatingBar.builder(
                                    initialRating: rating,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 30.0,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: kColor1,
                                    ),
                                    onRatingUpdate: (newRating) {
                                      setState(() {
                                        rating = newRating;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  Material(
                                    elevation: 5.0,
                                    color: kColor1,
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: MaterialButton(
                                      onPressed: () {},
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitReview() async {
    if (nameController.text.isNotEmpty && reviewController.text.isNotEmpty) {
      Map<String, dynamic> newReview = {
        'name': nameController.text,
        'content': reviewController.text,
        'rating': rating,
      };

      setState(() {
        selectedPlace['reviews'].add(newReview);
      });

      nameController.clear();
      reviewController.clear();
      setState(() {
        rating = 0;
      });

      await MongoDatabase.addReview(selectedPlace['title'], newReview);
    }
  }
}
