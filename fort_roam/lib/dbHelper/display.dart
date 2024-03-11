// import 'package:flutter/material.dart';
// import 'package:fort_roam/dbHelper/MongodbModel.dart';
// import 'package:fort_roam/dbHelper/mongodb.dart';

// class MongoDbDisplay extends StatefulWidget {
//   const MongoDbDisplay({super.key});

//   @override
//   State<MongoDbDisplay> createState() => _MongoDbDisplayState();
// }

// class _MongoDbDisplayState extends State<MongoDbDisplay> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Display Commercial Activities'),
//         ),
//         body: SafeArea(
//           child: FutureBuilder(
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else {
//                 if (snapshot.hasData) {
//                   var totalData = snapshot.data.length;
//                   print("Total Data " + totalData.toString());
//                   return ListView.builder(
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (context, index) {
//                         return displayCard(
//                             MongodbModel.fromJson(snapshot.data[index]),
//                             index + 1);
//                       });
//                 } else {
//                   return Center(
//                       child: Text(
//                     "No Data Found",
//                   ));
//                 }
//               }
//             },
//             future: MongoDatabase.getData(),
//           ),
//         ));
//   }

//   Widget displayCard(MongodbModel data, int number) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("ID: ${data.id.oid}"),
//           SizedBox(height: 10),
//           //  Text("Address: ${data.address}"),
//           SizedBox(height: 10),
//           //    Text("Name: ${data.name}"),
//           SizedBox(height: 10),
//           //   Text("Description: ${data.description}"),
//           SizedBox(height: 10),
//           //  Text("Website URL: ${data.webSiteUrl}"),
//           SizedBox(height: 10),
//           //  Text("Type of the Place: ${data.typeOfThePlace}"),
//           SizedBox(height: 10),
//           Text(number.toString()),
//         ],
//       ),
//     );
//   }
// }
