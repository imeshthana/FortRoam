import 'package:flutter/material.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';

class ItemsList extends StatelessWidget {
  ItemsList({
    super.key,
  });

  List<Map<String, String>> cardItems = [
    {
      'image': 'images/1.jpg',
      'title': 'Lighthouse',
    },
    {
      'image': 'images/2.jpg',
      'title': 'Jewelleries',
    },
    {
      'image': 'images/3.jpg',
      'title': 'Fort Jump',
    },
    {
      'image': 'images/4.jpg',
      'title': 'Museum',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
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
                          image: cardItems[index]['image']!,
                          title: cardItems[index]['title']!,
                          titleHeroTag: titleHeroTag,
                          imageHeroTag: imageHeroTag,
                        ),
                        type: PageTransitionType.scale,
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 500),
                      ));
                },
                child: Container(
                  width: 150.0,
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.only(left: 0, right: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Hero(
                                tag: imageHeroTag,
                                child: Image.asset(
                                  cardItems[index]['image']!,
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
                              cardItems[index]['title']!,
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
            })));
  }
}
