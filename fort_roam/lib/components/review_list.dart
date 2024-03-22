import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math';

class ReviewList extends StatelessWidget {
  ReviewList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cardItems;

    List<Map<String, dynamic>> data = [
      {
        'name': 'John Doe',
        'review': 'This place is amazing. I would recommend it to anyone.',
        'rating': '5'
      },
      {
        'name': 'Jane Doe',
        'review': 'This place is amazing. I would recommend it to anyone.',
        'rating': '4'
      },
      {
        'name': 'John Doe',
        'review': 'This place is amazing. I would recommend it to anyone.',
        'rating': '2'
      },
      {
        'name': 'Jane Doe',
        'review': 'This place is amazing. I would recommend it to anyone.',
        'rating': '3'
      },
      {
        'name': 'John Doe',
        'review': 'This place is amazing. I would recommend it to anyone.',
        'rating': '3'
      },
      {
        'name': 'Jane Doe',
        'review': 'This place is amazing. I would recommend it to anyone.',
        'rating': '5'
      },
      {
        'name': 'John Doe',
        'review': 'This place is amazing. I would recommend it to anyone.',
        'rating': '2'
      },
    ];

    final random = Random();
    final shuffledPlaces = [...data]..shuffle(random);

    cardItems = shuffledPlaces.take(5).toList();

    return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(cardItems.length, (index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Card(
                  color: Colors.grey[300],
                  elevation: 0,
                  margin: EdgeInsets.only(left: 0, right: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index]['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        RatingBarIndicator(
                            itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: kColor1,
                                ),
                            itemSize: 20,
                            rating: double.parse(data[index]['rating'])),
                        SizedBox(height: 8.0),
                        Text(data[index]['review']),
                      ],
                    ),
                  ),
                ),
              );
            })));
  }
}
