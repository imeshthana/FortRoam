import 'package:flutter/material.dart';

class CardItemsContainer extends StatelessWidget {
  CardItemsContainer({
    super.key,
  });

  List<Map<String, String>> cardItems = [
    {
      'image': 'images/1.jpg',
      'name': 'xwedxecw',
    },
    {
      'image': 'images/2.jpg',
      'name': 'ecewcewc',
    },
    {
      'image': 'images/3.jpg',
      'name': 'edewccew',
    },
    {
      'image': 'images/4.jpg',
      'name': 'xewxwxexw',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(cardItems.length, (index) {
              return GestureDetector(
                onTap: () {},
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
                              child: Image.asset(
                                cardItems[index]['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            cardItems[index]['name']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
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
