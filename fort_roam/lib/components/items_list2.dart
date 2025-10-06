import 'package:flutter/material.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';

class ItemsList2 extends StatelessWidget {
  ItemsList2({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(data.length, (index) {
              UniqueKey imageHeroTag = UniqueKey();
              UniqueKey titleHeroTag = UniqueKey();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        child: PlaceScreen(
                          title: data[index]['title']!,
                          titleHeroTag: titleHeroTag,
                          imageHeroTag: imageHeroTag,
                          data: data,
                          qrPlace: false,
                        ),
                        type: PageTransitionType.scale,
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 500),
                      ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
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
                                child: Image.network(
                                  data[index]['image']!,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.grey[600],
                                        size: 50,
                                      ),
                                    );
                                  },
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
                              data[index]['title']!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              ),
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
