import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/review_list.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/components/titles.dart';
import 'package:fort_roam/dbHelper/mongodb_model.dart';
import 'package:fort_roam/dbHelper/fav_places.dart';
import 'package:fort_roam/dbHelper/mongodb.dart';
import 'package:fort_roam/screens/map_screen.dart';
import 'package:fort_roam/screens/place_map_screen.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:avatar_glow/avatar_glow.dart';

class PlaceScreen extends StatefulWidget {
  PlaceScreen(
      {super.key,
      // required this.image,
      required this.title,
      this.imageHeroTag,
      this.titleHeroTag,
      required this.qrPlace,
      required this.data});

  static String id = 'place_screen';

  // final String image;
  final String title;
  final UniqueKey? imageHeroTag;
  final UniqueKey? titleHeroTag;
  final bool qrPlace;
  final List<Map<String, dynamic>> data;

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  late Map<String, dynamic> selectedPlace;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  late double rating;
  late double userRating;
  late List<Object> reviews;

  FavPlaces db = FavPlaces();

  final favBox = Hive.openBox('favBox');

  late bool isFavorite;

  getPlace() {
    selectedPlace =
        widget.data.firstWhere((place) => place['title'] == widget.title);
    reviews = (selectedPlace['reviews'] as List<dynamic>).cast<Object>();
    rating = double.parse(calculateAverageRating(reviews).toStringAsFixed(1));
  }

  void submitReview() async {
    if (nameController.text.isNotEmpty && reviewController.text.isNotEmpty) {
      Object newReview = {
        'name': nameController.text,
        'content': reviewController.text,
        'rating': userRating,
      };

      setState(() {
        selectedPlace['reviews'].add(newReview);
      });

      nameController.clear();
      reviewController.clear();
      setState(() {
        userRating = 0;
      });

      await MongoDatabase.addReview(selectedPlace['title'], newReview);
    }
  }

  double calculateAverageRating(List<Object> reviews) {
    if (reviews.isEmpty) return 5.0;
    double sum = 0;
    for (var review in reviews.cast<Map<String, dynamic>>()) {
      sum += review['rating'];
    }
    return sum / reviews.length;
  }

  @override
  void initState() {
    super.initState();
    getPlace();
    isFavorite = db.getFavoritePlaces().contains(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 15, right: 5),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.volume_up,
            color: Colors.white,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
          backgroundColor: kColor1,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      // appBar: CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            leading: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: MediaQuery.of(context).size.height * 0.04,
            ),
            automaticallyImplyLeading: false,
            stretch: true,
            pinned: false,
            elevation: 0,
            centerTitle: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.45,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.blurBackground],
              background: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: widget.qrPlace == true
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(selectedPlace['imageURL']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Hero(
                              tag: widget.imageHeroTag.toString(),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        selectedPlace['imageURL']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0.0),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0,
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
            ),
          ),
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 0,
            // expandedHeight: 100,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.085,
              ),
              child: SizedBox(height: 10),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.045,
                ),
                Center(
                    child: widget.qrPlace == true
                        ? Titles(title: widget.title)
                        : Hero(
                            tag: widget.titleHeroTag.toString(),
                            child: Titles(title: widget.title))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(103, 168, 168, 168),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0075,
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.0075,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(rating.toString(),
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.04,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                RatingBarIndicator(
                                  rating: rating,
                                  itemSize: MediaQuery.of(context).size.height *
                                      0.025,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: kColor1,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Overall Rating',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(103, 168, 168, 168),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: PlaceMapScreen(
                                      title: widget.title,
                                      data: widget.data,
                                    ),
                                    type: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 500),
                                    reverseDuration:
                                        Duration(milliseconds: 500)));
                          },
                          color: Colors.grey[300],
                          // shape: CircleBorder(),
                          // padding: EdgeInsets.all(12),
                          icon: Icon(
                            Icons.directions,
                            color: kColor1,
                            size: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(103, 168, 168, 168),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                              if (isFavorite) {
                                db.addFavoritePlace(widget.title);
                              } else {
                                db.removeFavoritePlace(widget.title);
                              }
                            });
                          },
                          color: kColor4,
                          // shape: CircleBorder(),
                          // padding: EdgeInsets.all(12),
                          // icon: Icon(
                          //   isFavorite ? Icons.favorite : Icons.favorite_border,
                          //   color: kColor1,
                          //   size: MediaQuery.of(context).size.height * 0.04,
                          // ),
                          icon: AvatarGlow(
                            animate: isFavorite,
                            glowColor: isFavorite ? kColor1 : kColor4,
                            glowRadiusFactor: 1,
                            glowCount: 1,
                            glowShape: BoxShape.circle,
                            duration: Duration(milliseconds: 500),
                            repeat: false,
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: kColor1,
                              size: MediaQuery.of(context).size.height * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Container(
                // margin: EdgeInsets.only(top: 350),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.02,
                      ),
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SubTitles(subTitle: 'Description'),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Container(
                              child: selectedPlace['description'] == ''
                                  ? Text(
                                      'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture.',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      selectedPlace['description'],
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            SubTitles(subTitle: 'Reviews and Ratings'),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                            ReviewList(
                                data: reviews.cast<Map<String, dynamic>>()),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            SubTitles(subTitle: 'Add Your Review'),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                            Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                            width: 2, color: kColor3),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    controller: reviewController,
                                    decoration: InputDecoration(
                                      labelText: 'Review',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          color: kColor3,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    maxLines: 3,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 30.0,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: kColor1,
                                    ),
                                    onRatingUpdate: (newRating) {
                                      setState(() {
                                        userRating = newRating;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  Material(
                                    elevation: 5.0,
                                    color: kColor1,
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: MaterialButton(
                                      onPressed: () {
                                        submitReview();
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
