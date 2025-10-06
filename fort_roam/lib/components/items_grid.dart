import 'package:flutter/material.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:shimmer/shimmer.dart';

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
                            child: Image.network(
                              place['image']!,
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
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: titleHeroTag,
                      child: Text(
                        place['title']!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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
