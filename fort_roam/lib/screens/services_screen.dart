import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/items_list2.dart';
import 'package:fort_roam/components/sub_titles.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;
  static String id = 'support_screen';

  List<Map<String, dynamic>> others = [];

  List<Map<String, dynamic>> filterPlacesBySubtype(String subtype) {
    return data.where((place) => place['subtype'] == subtype).toList();
  }

  List<Map<String, dynamic>> filterOtherPlacesBySubtype() {
    List<Map<String, dynamic>> police;
    List<Map<String, dynamic>> post;
    police = data.where((place) => place['subtype'] == 'police').toList();
    post = data.where((place) => place['subtype'] == 'post').toList();
    police.addAll(post);
    others = police;
    return others;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      appBar: CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                SubTitles(subTitle: 'Banks'),
                SizedBox(height: 20.0),
                ItemsList2(data: filterPlacesBySubtype('bank')),
                SubTitles(subTitle: 'Schools'),
                SizedBox(height: 20.0),
                ItemsList2(data: filterPlacesBySubtype('school')),
                SubTitles(subTitle: 'Parking'),
                SizedBox(height: 20.0),
                ItemsList2(data: filterPlacesBySubtype('parking')),
                SubTitles(subTitle: 'Taxies'),
                SizedBox(height: 20.0),
                ItemsList2(data: filterPlacesBySubtype('taxi')),
                SubTitles(subTitle: 'Others'),
                SizedBox(height: 20.0),
                ItemsList2(data: filterOtherPlacesBySubtype()),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
