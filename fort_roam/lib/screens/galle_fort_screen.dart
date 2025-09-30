import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/components/titles.dart';

class GalleFortScreen extends StatelessWidget {
  const GalleFortScreen(
      {super.key, required this.imageHeroTag, required this.titleHeroTag});

  final UniqueKey imageHeroTag;
  final UniqueKey titleHeroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 15, right: 5),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.volume_up, color: Colors.white, size: 30.0),
          backgroundColor: kColor1,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 350.0,
                        child: Hero(
                          tag: imageHeroTag,
                          child: Image.asset(
                            'images/gallefort.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.0),
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Hero(
                        tag: titleHeroTag,
                        child: Titles(
                          title: 'Galle Fort',
                        ))),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: SubTitles(subTitle: 'Description')),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture.',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
