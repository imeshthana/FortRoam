// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:fort_roam/components/app_bar1.dart';
// import 'package:fort_roam/components/constants.dart';
// import 'package:fort_roam/components/gesture_card.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:fort_roam/components/items_grid.dart';
// import 'package:fort_roam/components/navigation_bar.dart';
// import 'package:fort_roam/components/search_bar.dart';
// import 'package:fort_roam/components/sub_titles.dart';
// import 'package:fort_roam/dbHelper/fav_places.dart';
// import 'package:fort_roam/screens/custom_route_map_screen.dart';
// import 'package:fort_roam/screens/place_screen.dart';
// import 'package:fort_roam/screens/best_route_map_screen.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:reorderable_grid_view/reorderable_grid_view.dart';

// class FavouritesScreen extends StatefulWidget {
//   FavouritesScreen({super.key, required this.data});

//   final List<Map<String, dynamic>> data;
//   static String id = 'favourites_screen';

//   @override
//   State<FavouritesScreen> createState() => _FavouritesScreenState();
// }

// class _FavouritesScreenState extends State<FavouritesScreen> {
//   final FavPlaces db = FavPlaces();
//   late List<Map<String, dynamic>> filteredPlaces;
//   late List<String> favoritePlaces;
//   late List<String> originalOrder;
//   bool _dataChanged = false;

//   @override
//   void initState() {
//     super.initState();
//     favoritePlaces = db.getFavoritePlaces();
//     filteredPlaces = widget.data
//         .where((place) => favoritePlaces.contains(place['title']))
//         .toList();
//     originalOrder = List<String>.from(favoritePlaces);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     if (_dataChanged) {
//       db.updateFavoritePlaces(favoritePlaces);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // bottomNavigationBar: CustomNavigationBar(),
//       appBar: CustomAppBar(),

//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: kColor2,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15.0),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             PageTransition(
//                               child: BestRouteMapScreen(data: widget.data),
//                               type: PageTransitionType.bottomToTop,
//                               duration: Duration(milliseconds: 500),
//                               reverseDuration: Duration(milliseconds: 500),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'Best Route',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: kColor2,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15.0),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             PageTransition(
//                               child: CustomRouteMapScreen(
//                                 data: filteredPlaces,
//                               ),
//                               type: PageTransitionType.bottomToTop,
//                               duration: Duration(milliseconds: 500),
//                               reverseDuration: Duration(milliseconds: 500),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'Custom Route',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 20.0),
//                     SubTitles(subTitle: 'Favourites'),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Center(
//                       child: ReorderableGridView.builder(
//                         onReorder: (oldIndex, newIndex) {
//                           // setState(() {
//                           //   final element = filteredPlaces.removeAt(oldIndex);
//                           //   filteredPlaces.insert(newIndex, element);
//                           // });

//                           // setState(() {
//                           //   final element = filteredPlaces.removeAt(oldIndex);
//                           //   filteredPlaces.insert(newIndex, element);

//                           //   db.addFavoritePlaceByIndex(newIndex, element['title']);

//                           //   // favoritePlaces = filteredPlaces
//                           //   //     .map((place) => place['title'].toString())
//                           //   //     .toList();
//                           //   // db.updateFavoritePlaces(favoritePlaces);

//                           //   favoritePlaces = db.getFavoritePlaces();

//                           // });
//                           setState(() {
//                             if (oldIndex < newIndex) {
//                               newIndex -= 1;
//                             }
//                             final element = filteredPlaces.removeAt(oldIndex);
//                             filteredPlaces.insert(newIndex, element);
//                             final String movedPlace =
//                                 favoritePlaces.removeAt(oldIndex);
//                             favoritePlaces.insert(newIndex, movedPlace);
//                             _dataChanged = true;
//                           });
//                         },
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 25),
//                         itemCount: filteredPlaces.length,
//                         itemBuilder: (context, index) {
//                           UniqueKey imageHeroTag = UniqueKey();
//                           UniqueKey titleHeroTag = UniqueKey();
//                           final place = filteredPlaces[index];
//                           return GestureDetector(
//                             key: ValueKey(index),
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   PageTransition(
//                                     child: PlaceScreen(
//                                       image: filteredPlaces[index]['image']!,
//                                       title: filteredPlaces[index]['title']!,
//                                       titleHeroTag: titleHeroTag,
//                                       imageHeroTag: imageHeroTag,
//                                       onShowPlaceOnMap: true,
//                                       data: filteredPlaces,
//                                     ),
//                                     type: PageTransitionType.scale,
//                                     alignment: Alignment.center,
//                                     duration: Duration(milliseconds: 500),
//                                   ));
//                             },
//                             child: Stack(
//                               children: [
//                                 Card(
//                                   elevation: 4,
//                                   margin: EdgeInsets.only(
//                                     left: 10,
//                                     right: 10,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Expanded(
//                                         child: Material(
//                                           elevation: 0.0,
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(15.0),
//                                             child: Hero(
//                                               tag: imageHeroTag,
//                                               child: Image.asset(
//                                                 place['image']!,
//                                                 fit: BoxFit.cover,
//                                                 width: double.infinity,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(height: 8.0),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Hero(
//                                           tag: titleHeroTag,
//                                           child: Text(
//                                             place['title']!,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 5,
//                                   left: 17.5,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.white,
//                                     ),
//                                     padding: EdgeInsets.all(5.0),
//                                     child: Text(
//                                       '${index + 1}',
//                                       style: TextStyle(
//                                         color: kColor1,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fort_roam/components/app_bar3.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/items_grid.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/dbHelper/fav_places.dart';
import 'package:fort_roam/screens/custom_route_map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:fort_roam/screens/best_route_map_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class FavouritesScreen extends StatefulWidget {
  FavouritesScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;
  static String id = 'favourites_screen';

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final FavPlaces db = FavPlaces();
  late List<Map<String, dynamic>> filteredPlaces;
  late List<String> favoritePlaces;
  late List<String> originalOrder;
  bool dataChanged = false;

  @override
  void initState() {
    super.initState();
    favoritePlaces = db.getFavoritePlaces();
    filteredPlaces = widget.data
        .where((place) => favoritePlaces.contains(place['title']))
        .toList();
    originalOrder = List<String>.from(favoritePlaces);
  }

  @override
  void dispose() {
    super.dispose();
    if (dataChanged) {
      db.updateFavoritePlaces(favoritePlaces);
    }
  }

  void removePlace(String placeTitle) {
    setState(() {
      filteredPlaces.removeWhere((place) => place['title'] == placeTitle);
      favoritePlaces.remove(placeTitle);
      dataChanged = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: BestRouteMapScreen(data: widget.data),
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 500),
                              reverseDuration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Text(
                          'Best Route',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: CustomRouteMapScreen(
                                data: filteredPlaces,
                              ),
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 500),
                              reverseDuration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Text(
                          'Custom Route',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              SubTitles(subTitle: 'Favourites'),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: filteredPlaces.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          'No any favourite places found!',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        children: [
                          ReorderableListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final element =
                                    filteredPlaces.removeAt(oldIndex);
                                filteredPlaces.insert(newIndex, element);
                                final String movedPlace =
                                    favoritePlaces.removeAt(oldIndex);
                                favoritePlaces.insert(newIndex, movedPlace);
                                dataChanged = true;
                              });
                            },
                            children: List.generate(
                              filteredPlaces.length,
                              (index) {
                                UniqueKey imageHeroTag = UniqueKey();
                                UniqueKey titleHeroTag = UniqueKey();
                                final place = filteredPlaces[index];

                                return Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.horizontal,
                                  onDismissed: (direction) {
                                    removePlace(place['title']!);
                                  },
                                  background: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: kColor1,
                                    ),
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 10,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                      ),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    key: ValueKey(index),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                            child: PlaceScreen(
                                              // image: filteredPlaces[index]['image']!,
                                              title: filteredPlaces[index]
                                                  ['title']!,
                                              titleHeroTag: titleHeroTag,
                                              imageHeroTag: imageHeroTag,
                                              qrPlace: false,
                                              data: filteredPlaces,
                                            ),
                                            type: PageTransitionType.scale,
                                            alignment: Alignment.center,
                                            duration:
                                                Duration(milliseconds: 500),
                                          ));
                                    },
                                    child: Container(
                                      key: ValueKey(index),
                                      margin: EdgeInsets.only(
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Row(
                                            children: [
                                              Material(
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: Hero(
                                                    tag: imageHeroTag,
                                                    child: Image.asset(
                                                      place['image']!,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.1,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.1,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8.0),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Hero(
                                                  tag: titleHeroTag,
                                                  child: Text(
                                                    place['title']!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
