// import 'package:flutter/material.dart';

// class GestureCard extends StatefulWidget {
//   GestureCard({required this.image, required this.name});

//   final String image;
//   final String name;

//   @override
//   State<GestureCard> createState() => _GestureCardState();
// }

// class _GestureCardState extends State<GestureCard> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {},
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Stack(children: [
//               AnimatedPositioned(
//                 duration: Duration(milliseconds: 500),
//                 bottom: isExpanded ? 150 : 100,
//                 child: Card(
//                   elevation: 10.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Container(
//                       width: 120,
//                       height: 100.0,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.asset(
//                           widget.image,
//                           fit: BoxFit.fill,
//                         ),
//                       )),
//                 ),
//               ),
//             ]),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               widget.name,
//               style: TextStyle(fontWeight: FontWeight.w500),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
