import 'package:flutter/material.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';

class ItemsGrid extends StatelessWidget {
  const ItemsGrid({
    super.key,
    required this.places,
  });

  final List<Map<String, dynamic>> places;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 20),
      itemCount: places.length,
      itemBuilder: (context, index) {
        UniqueKey imageHeroTag = UniqueKey();
        UniqueKey titleHeroTag = UniqueKey();
        final place = places[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                  child: PlaceScreen(
                    image: places[index]['image']!,
                    title: places[index]['title']!,
                    titleHeroTag: titleHeroTag,
                    imageHeroTag: imageHeroTag,
                    onShowPlaceOnMap: true,
                    data: places,
                  ),
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 500),
                ));
          },
          child: Card(
            elevation: 0,
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
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
                          place['image']!,
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
                      place['title']!,
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
        );
      },
    );
  }
}
