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

  final List<Map<String, String>> placeList;

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
                          image: placeList[index]['image']!,
                          title: placeList[index]['title']!,
                          titleHeroTag: titleHeroTag,
                          imageHeroTag: imageHeroTag,
                        ),
                        type: PageTransitionType.scale,
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 300),
                      ));
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
                              child: Image.asset(
                                placeList[index]['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
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
                            placeList[index]['title']!,
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
