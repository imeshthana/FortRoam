import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math';

class ItemsList extends StatelessWidget {
  ItemsList({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cardItems;

    final random = Random();
    final shuffledPlaces = [...data]..shuffle(random);

    cardItems = shuffledPlaces.take(5).toList();

    return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(cardItems.length, (index) {
              UniqueKey imageHeroTag = UniqueKey();
              UniqueKey titleHeroTag = UniqueKey();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        child: PlaceScreen(
                          // image: cardItems[index]['image']!,
                          title: cardItems[index]['title']!,
                          titleHeroTag: titleHeroTag,
                          imageHeroTag: imageHeroTag,
                          data: cardItems,
                          qrPlace: false,
                        ),
                        type: PageTransitionType.scale,
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 500),
                      ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    margin: EdgeInsets.only(left: 0, right: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Hero(
                              tag: imageHeroTag,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      cardItems[index]['image']!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                            tag: titleHeroTag,
                            child: Text(
                              cardItems[index]['title']!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })));
  }
}
