import 'package:flutter/material.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class ItemsGrid extends StatefulWidget {
  const ItemsGrid({
    super.key,
    required this.places,
  });

  final List<Map<String, dynamic>> places;

  @override
  State<ItemsGrid> createState() => _ItemsGridState();
}

class _ItemsGridState extends State<ItemsGrid> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ReorderableGridView.builder(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            final element = widget.places.removeAt(oldIndex);
            widget.places.insert(newIndex, element);
          });
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 20),
        itemCount: widget.places.length,
        itemBuilder: (context, index) {
          UniqueKey imageHeroTag = UniqueKey();
          UniqueKey titleHeroTag = UniqueKey();
          final place = widget.places[index];
          return GestureDetector(
            key: ValueKey(index),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: PlaceScreen(
                      // image: widget.places[index]['image']!,
                      title: widget.places[index]['title']!,
                      titleHeroTag: titleHeroTag,
                      imageHeroTag: imageHeroTag,
                      data: widget.places,
                      qrPlace: false,
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
                           child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        place['imageURL']!,),
                                    fit: BoxFit.cover,
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
      ),
    );
  }
}
