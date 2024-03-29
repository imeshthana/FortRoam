import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math';

class ReviewList extends StatefulWidget {
  ReviewList({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> reviews;

    List<Map<String, dynamic>> cardItems = [
      {
        "name": "Alice Smith",
        "review": "Fantastic experience! Highly recommend this place.",
        "rating": "5"
      },
      {
        "name": "Bob Johnson",
        "review": "Great place to visit. Definitely worth it.",
        "rating": "4"
      },
      {
        "name": "Eva Brown",
        "review": "Absolutely wonderful. Would recommend without hesitation.",
        "rating": "2"
      },
      {
        "name": "Michael Clark",
        "review": "Lovely atmosphere and great service.",
        "rating": "3"
      },
      {
        "name": "Sarah Davis",
        "review": "Incredible experience! Will definitely come back.",
        "rating": "3"
      },
      {
        "name": "Thomas Wilson",
        "review": "Fantastic place! Can't wait to visit again.",
        "rating": "5"
      },
      {
        "name": "Olivia Taylor",
        "review": "Amazing spot! Highly recommended.",
        "rating": "2"
      }
    ];

    return Container(
      child: widget.data.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No reviews yet!',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.0225,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Be the first reviewer',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.0225,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(widget.data.length, (index) {
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
                                widget.data[index]['name'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              RatingBarIndicator(
                                  itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: kColor1,
                                      ),
                                  itemSize: 20,
                                  rating: widget.data[index]['rating']),
                              SizedBox(height: 8.0),
                              Text(widget.data[index]['content']),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))),
    );
  }
}
