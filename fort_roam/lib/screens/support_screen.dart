import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/gesture_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fort_roam/components/navigation_bar.dart';
import 'package:fort_roam/components/search_bar.dart';
import 'package:fort_roam/components/sub_titles.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});
  static String id = 'support_screen';

  final Map<String, String> cardImages = {
    'images/1.jpg': 'xwedxecw',
    'images/2.jpg': 'ecewcewc',
    'images/3.jpg': 'edewccew',
    'images/4.jpg': 'xewxwxexw'
  };

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
                // Center(child: CustomSearchBar()),
                SizedBox(height: 20.0),
                SubTitles(subTitle: 'Support Centeres'),
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: cardImages.length,
                  itemBuilder: (context, index) {
                    final imageKey = cardImages.keys.elementAt(index);
                    final imageValue = cardImages.values.elementAt(index);

                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 0,
                        margin: EdgeInsets.only(left: 10, right: 10),
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
                                    imageKey,
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
                                imageValue,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
