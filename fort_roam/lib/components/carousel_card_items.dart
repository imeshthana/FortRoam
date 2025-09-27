import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';

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
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => PlaceScreen(
                  //         image: cardItems[index]['image']!,
                  //         title: cardItems[index]['name']!,
                  //         titleHeroTag: titleHeroTag,
                  //         imageHeroTag: imageHeroTag,)));

                  Navigator.push(
                      context,
                      PageTransition(
                          child: PlaceScreen(
                            // image: placeList[index]['image']!.toString(),
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
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        placeList[index]['image']!.toString()),
                                    fit: BoxFit.fill,
                                  ),
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
