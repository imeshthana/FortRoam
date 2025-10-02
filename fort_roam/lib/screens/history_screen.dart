import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/carousel_card_items.dart';
import 'package:fort_roam/components/sub_titles.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;
  static String id = 'history_screen';

  List<Map<String, dynamic>> filterPlacesBySubtype(String subtype) {
    return data.where((place) => place['subtype'] == subtype).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubTitles(subTitle: 'Museums')),
            SizedBox(
              height: 20,
            ),
            CarouselCardItems(
              placeList: filterPlacesBySubtype('museum'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubTitles(subTitle: "Bastions")),
            SizedBox(
              height: 20,
            ),
            CarouselCardItems(
              placeList: filterPlacesBySubtype('bastion'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubTitles(subTitle: "Others")),
            SizedBox(
              height: 20,
            ),
            CarouselCardItems(
              placeList: filterPlacesBySubtype('others'),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:fort_roam/components/carousel_card_items.dart';
// import 'package:fort_roam/components/sub_titles.dart';
// import 'package:fort_roam/dbHelper/MongodbModel.dart';
// import 'package:fort_roam/dbHelper/mongodb.dart';

// class HistoryScreen extends StatefulWidget {
//   HistoryScreen({Key? key}) : super(key: key);
//   static String id = 'history_screen';

//   @override
//   _HistoryScreenState createState() => _HistoryScreenState();
// }

// class _HistoryScreenState extends State<HistoryScreen> {
//   late List<MongodbModel> museums;
//   late List<MongodbModel> bastions;
//   late List<MongodbModel> others;

//   @override
//   void initState() {
//     super.initState();
//     fetchPlaces();
//   }

//   void fetchPlaces() async {
//     try {
//       museums = await MongoDatabase.getPlacesBySubtype('museum');
//       bastions = await MongoDatabase.getPlacesBySubtype('bastion');
//       others = await MongoDatabase.getPlacesBySubtype('others');
//       setState(() {});
//     } catch (e) {
//       print('Error fetching places: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('History'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SubTitles(subTitle: 'Museums'),
//             SizedBox(height: 20),
//             museums != null
//                 ? CarouselCardItems(placeList: museums)
//                 : CircularProgressIndicator(),
//             SizedBox(height: 20),
//             SubTitles(subTitle: 'Bastions'),
//             SizedBox(height: 20),
//             bastions != null
//                 ? CarouselCardItems(placeList: bastions)
//                 : CircularProgressIndicator(),
//             SizedBox(height: 20),
//             SubTitles(subTitle: 'Others'),
//             SizedBox(height: 20),
//             others != null
//                 ? CarouselCardItems(placeList: others)
//                 : CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }
