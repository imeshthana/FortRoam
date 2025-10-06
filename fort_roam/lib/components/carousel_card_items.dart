import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class CarouselCardItems extends StatelessWidget {
  CarouselCardItems({
    super.key,
    required this.placeList,
  });

  final List<Map<String, dynamic>> placeList;

  final scrollController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: CarouselSlider(
          carouselController: scrollController,
          options: CarouselOptions(
            pageSnapping: false,
            initialPage: 0,
            enlargeFactor: 0.4,
            viewportFraction: 0.65,
            enableInfiniteScroll: true,
            height: MediaQuery.of(context).size.height * 0.65,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => scrollController.animateToPage(
                index,
                duration: Duration(seconds: 1),
                curve: Curves.ease),
          ),
          items: List<Widget>.generate(placeList.length, (index) {
            UniqueKey imageHeroTag = UniqueKey();
            UniqueKey titleHeroTag = UniqueKey();

            return Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: PlaceScreen(
                            title: placeList[index]['title']!.toString(),
                            titleHeroTag: titleHeroTag,
                            imageHeroTag: imageHeroTag,
                            data: placeList,
                            qrPlace: false,
                          ),
                          type: PageTransitionType.scale,
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 500),
                          reverseDuration: Duration(microseconds: 500)));
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Hero(
                              tag: imageHeroTag,
                              child: Container(
                                width: double.infinity,
                                child: Image.network(
                                  placeList[index]['image']!.toString(),
                                  fit: BoxFit.fill,
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
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: titleHeroTag,
                          child: Text(
                            placeList[index]['title']!.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
