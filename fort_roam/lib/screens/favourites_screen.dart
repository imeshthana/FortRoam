import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar3.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/dbHelper/fav_places.dart';
import 'package:fort_roam/screens/custom_route_map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:fort_roam/screens/best_route_map_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

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
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kColor2,
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
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kColor2,
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
                              color: Colors.white,
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
              SizedBox(height: 20),
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
                                                    child: Container(
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
                                                      child: Image.network(
                                                        place['image']!,
                                                        fit: BoxFit.fitHeight,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;
                                                          return Shimmer
                                                              .fromColors(
                                                            baseColor: Colors
                                                                .grey[300]!,
                                                            highlightColor:
                                                                Colors
                                                                    .grey[100]!,
                                                            child: Container(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          );
                                                        },
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Container(
                                                            color: Colors
                                                                .grey[300],
                                                            child: Icon(
                                                              Icons
                                                                  .broken_image,
                                                              color: Colors
                                                                  .grey[600],
                                                              size: 40,
                                                            ),
                                                          );
                                                        },
                                                      ),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
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
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
