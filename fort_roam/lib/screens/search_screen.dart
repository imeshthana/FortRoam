// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:fort_roam/components/constants.dart';
// import 'package:fort_roam/components/items_grid.dart';
// import 'package:fort_roam/components/sub_titles.dart';
// import 'package:fort_roam/screens/place_screen.dart';
// import 'package:page_transition/page_transition.dart';
// import '../components/app_bar2.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class VoiceScreen extends StatefulWidget {
//   VoiceScreen({super.key, required this.data});

//   final List<Map<String, dynamic>> data;
//   static String id = 'voice_screen';

//   @override
//   State<VoiceScreen> createState() => _VoiceScreenState();
// }

// class _VoiceScreenState extends State<VoiceScreen> {
//   late String text;
//   var isListening = false;
//   Color iColor = kColor1;
//   Color bColor = Colors.white;
//   List<Map<String, dynamic>> filteredPlaces = [];

//   TextEditingController controller = TextEditingController();

//   SpeechToText speech = SpeechToText();

//   void filterPlacesByKeywords(String keywords) {
//     keywords = keywords.toLowerCase();

//     List<Map<String, dynamic>> matchingPlaces = [];

//     for (var place in widget.data) {
//       // if (place['type']!.toLowerCase().contains(keywords.toLowerCase()) ||
//       //     place['subtype']!.toLowerCase().contains(keywords.toLowerCase()) ||
//       //     place['title']!.toLowerCase().contains(keywords.toLowerCase())) {
//       //   matchingPlaces.add(place);
//       // }

//       // if (keywords.toLowerCase().contains(place['type']!.toLowerCase()) ||
//       //     keywords.toLowerCase().contains(place['subtype']!.toLowerCase()) ||
//       //     keywords.toLowerCase().contains(place['title']!.toLowerCase())) {
//       //   matchingPlaces.add(place);
//       // }

//       if (place['type']!.toLowerCase().contains(keywords.toLowerCase()) ||
//           place['subtype']!.toLowerCase().contains(keywords.toLowerCase()) ||
//           place['title']!.toLowerCase().contains(keywords.toLowerCase()) ||
//           keywords.toLowerCase().contains(place['type']!.toLowerCase()) ||
//           keywords.toLowerCase().contains(place['subtype']!.toLowerCase()) ||
//           keywords.toLowerCase().contains(place['title']!.toLowerCase())) {
//         matchingPlaces.add(place);
//       }
//     }
//     setState(() {
//       filteredPlaces = matchingPlaces;
//       controller.text = keywords;
//     });
//   }

//   @override
//   void initState() {
//     text = '';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       floatingActionButton: Row(
//         children: [
//           Container(
//             margin: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).size.height * 0.025,
//                 left: MediaQuery.of(context).size.height * 0.025),
//             child: FloatingActionButton(
//               shape: CircleBorder(),
//               onPressed: () async {
//                 try {
//                   String qrCodeScanResult =
//                       await FlutterBarcodeScanner.scanBarcode(
//                           '#ffe25e3e', 'Cancel', false, ScanMode.QR);
//                   if (!mounted) {
//                     return;
//                   }
//                   setState(() {
//                     if (qrCodeScanResult == '-1') {
//                       text = "No any QR code found";
//                     } else{
//                       try {
//                       text = qrCodeScanResult.toString();
//                       Navigator.push(
//                           context,
//                           PageTransition(
//                             child: PlaceScreen(
//                               title: text,
//                               data: widget.data,
//                               qrPlace: true,
//                             ),
//                             type: PageTransitionType.scale,
//                             alignment: Alignment.center,
//                             duration: Duration(milliseconds: 500),
//                           ));
//                       } catch (e) {
//                         controller.text = qrCodeScanResult.toString();
//                       }
//                     }
//                   });
//                 } on PlatformException {
//                   text = "No any QR code found";
//                 }
//               },
//               child: Icon(Icons.qr_code,
//                   color: Colors.white,
//                   size: MediaQuery.of(context).size.height * 0.04),
//               backgroundColor: kColor1,
//               elevation: 5,
//             ),
//           ),
//           Spacer(),
//           Container(
//             margin: EdgeInsets.only(
//               bottom: MediaQuery.of(context).size.height * 0.025,
//               right: MediaQuery.of(context).size.height * 0.065,
//             ),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: kColor1, width: 2.0),
//             ),
//             child: AvatarGlow(
//               glowCount: 3,
//               glowRadiusFactor: 0.7,
//               animate: true,
//               duration: Duration(milliseconds: 1000),
//               repeat: true,
//               glowColor: kColor1,
//               startDelay: Duration(milliseconds: 1000),
//               child: GestureDetector(
//                 onTapDown: (details) async {
//                   if (!isListening) {
//                     var available = await speech.initialize();
//                     if (available) {
//                       setState(() {
//                         isListening = true;
//                         iColor = Colors.white;
//                         bColor = kColor1;
//                         speech.listen(onResult: (result) {
//                           setState(() {
//                             text = result.recognizedWords;
//                             filterPlacesByKeywords(result.recognizedWords);
//                           });
//                         });
//                       });
//                     }
//                   }
//                 },
//                 onTapUp: (details) {
//                   setState(() {
//                     isListening = false;
//                     bColor = Colors.white;
//                     iColor = kColor1;
//                   });
//                   speech.stop();
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: bColor,
//                   radius: MediaQuery.of(context).size.height * 0.035,
//                   child: Icon(
//                     Icons.mic,
//                     color: iColor,
//                     size: MediaQuery.of(context).size.height * 0.04,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.025,
//             ),
//             SubTitles(subTitle: 'Find a Place'),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.035),
//             TextField(
//               controller: controller,
//               onChanged: (typedText) {
//                 text = controller.text;
//                 filterPlacesByKeywords(typedText);
//               },
//               style: TextStyle(color: Colors.black),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: kColor3,
//                 labelText: 'Where do you want to go....',
//                 labelStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: MediaQuery.of(context).size.height * 0.0225),
//                 prefixIcon: Icon(Icons.search, color: Colors.white),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide: BorderSide(color: kColor1, width: 2.0),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide: BorderSide(color: kColor1, width: 2.0),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.never,
//               ),
//             ),
//             // Container(
//             //   padding: EdgeInsets.all(16.0),
//             //   decoration: BoxDecoration(
//             //     color: kColor2,
//             //     borderRadius: BorderRadius.circular(20),
//             //   ),
//             //   child: Row(
//             //     children: [
//             //       Icon(
//             //         Icons.search,
//             //         color: Colors.white,
//             //         size: 30,
//             //       ),
//             //       SizedBox(width: 10),
//             //       Text(
//             //         text,
//             //         style: TextStyle(fontSize: 17.5, color: Colors.white),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.025,
//             ),
//             if (filteredPlaces.isNotEmpty && text.isNotEmpty) ...[
//               SizedBox(height: MediaQuery.of(context).size.height * 0.025),
//               Expanded(
//                 child: SingleChildScrollView(
//                     child: ItemsGrid(places: filteredPlaces)),
//               ),
//               SizedBox(
//                 height: 30,
//               )
//             ],
//             if (filteredPlaces.isEmpty && text.isNotEmpty) ...[
//               Container(
//                 margin: EdgeInsets.only(
//                     top: 25,
//                     left: MediaQuery.of(context).size.height * 0.025,
//                     right: MediaQuery.of(context).size.height * 0.025),
//                 child: Text(
//                   'No any search results found!',
//                   style: TextStyle(
//                       fontSize: MediaQuery.of(context).size.height * 0.025,
//                       color: Colors.grey),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               )
//             ],

//             if (filteredPlaces.isEmpty && text.isEmpty) ...[
//               Container(
//                 margin: EdgeInsets.only(
//                     top: 25,
//                     left: MediaQuery.of(context).size.height * 0.025,
//                     right: MediaQuery.of(context).size.height * 0.025),
//                 child: Text(
//                   'Tap, hold and say where do you want to go...',
//                   style: TextStyle(
//                       fontSize: MediaQuery.of(context).size.height * 0.025,
//                       color: Colors.grey),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               )
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/items_grid.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../components/app_bar2.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceScreen extends StatefulWidget {
  VoiceScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;
  static String id = 'voice_screen';

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  late String text;
  var isListening = false;
  Color iColor = kColor1;
  Color bColor = Colors.white;
  List<Map<String, dynamic>> filteredPlaces = [];

  TextEditingController controller = TextEditingController();
  SpeechToText speech = SpeechToText();

  void filterPlacesByKeywords(String keywords) {
    keywords = keywords.toLowerCase();
    List<Map<String, dynamic>> matchingPlaces = [];

    for (var place in widget.data) {
      if (place['type']!.toLowerCase().contains(keywords.toLowerCase()) ||
          place['subtype']!.toLowerCase().contains(keywords.toLowerCase()) ||
          place['title']!.toLowerCase().contains(keywords.toLowerCase()) ||
          keywords.toLowerCase().contains(place['type']!.toLowerCase()) ||
          keywords.toLowerCase().contains(place['subtype']!.toLowerCase()) ||
          keywords.toLowerCase().contains(place['title']!.toLowerCase())) {
        matchingPlaces.add(place);
      }
    }
    setState(() {
      filteredPlaces = matchingPlaces;
      controller.text = keywords;
    });
  }

  void _openQRScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerScreen(
          onScan: (String scannedData) {
            setState(() {
              text = scannedData;
              try {
                Navigator.push(
                  context,
                  PageTransition(
                    child: PlaceScreen(
                      title: scannedData,
                      data: widget.data,
                      qrPlace: true,
                    ),
                    type: PageTransitionType.scale,
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 500),
                  ),
                );
              } catch (e) {
                controller.text = scannedData;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.025,
              left: MediaQuery.of(context).size.height * 0.025,
            ),
            child: FloatingActionButton(
              shape: CircleBorder(),
              onPressed: _openQRScanner,
              child: Icon(
                Icons.qr_code,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.04,
              ),
              backgroundColor: kColor1,
              elevation: 5,
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.025,
              right: MediaQuery.of(context).size.height * 0.065,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kColor1, width: 2.0),
            ),
            child: AvatarGlow(
              glowCount: 3,
              glowRadiusFactor: 0.7,
              animate: true,
              duration: Duration(milliseconds: 1000),
              repeat: true,
              glowColor: kColor1,
              startDelay: Duration(milliseconds: 1000),
              child: GestureDetector(
                onTapDown: (details) async {
                  if (!isListening) {
                    var available = await speech.initialize();
                    if (available) {
                      setState(() {
                        isListening = true;
                        iColor = Colors.white;
                        bColor = kColor1;
                        speech.listen(onResult: (result) {
                          setState(() {
                            text = result.recognizedWords;
                            filterPlacesByKeywords(result.recognizedWords);
                          });
                        });
                      });
                    }
                  }
                },
                onTapUp: (details) {
                  setState(() {
                    isListening = false;
                    bColor = Colors.white;
                    iColor = kColor1;
                  });
                  speech.stop();
                },
                child: CircleAvatar(
                  backgroundColor: bColor,
                  radius: MediaQuery.of(context).size.height * 0.035,
                  child: Icon(
                    Icons.mic,
                    color: iColor,
                    size: MediaQuery.of(context).size.height * 0.04,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            SubTitles(subTitle: 'Find a Place'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            TextField(
              controller: controller,
              onChanged: (typedText) {
                text = controller.text;
                filterPlacesByKeywords(typedText);
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: kColor3,
                labelText: 'Where do you want to go....',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.0225,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: kColor1, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: kColor1, width: 2.0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            if (filteredPlaces.isNotEmpty && text.isNotEmpty) ...[
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Expanded(
                child: SingleChildScrollView(
                  child: ItemsGrid(places: filteredPlaces),
                ),
              ),
              SizedBox(height: 30),
            ],
            if (filteredPlaces.isEmpty && text.isNotEmpty) ...[
              Container(
                margin: EdgeInsets.only(
                  top: 25,
                  left: MediaQuery.of(context).size.height * 0.025,
                  right: MediaQuery.of(context).size.height * 0.025,
                ),
                child: Text(
                  'No any search results found!',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
            ],
            if (filteredPlaces.isEmpty && text.isEmpty) ...[
              Container(
                margin: EdgeInsets.only(
                  top: 25,
                  left: MediaQuery.of(context).size.height * 0.025,
                  right: MediaQuery.of(context).size.height * 0.025,
                ),
                child: Text(
                  'Tap, hold and say where do you want to go...',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
            ],
          ],
        ),
      ),
    );
  }
}

// QR Scanner Screen using mobile_scanner
class QRScannerScreen extends StatefulWidget {
  final Function(String) onScan;

  const QRScannerScreen({super.key, required this.onScan});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Scan QR Code', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: Icon(Icons.flip_camera_ios),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              if (!isScanned) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                  setState(() {
                    isScanned = true;
                  });
                  String scannedData = barcodes.first.rawValue!;
                  Navigator.pop(context);
                  widget.onScan(scannedData);
                }
              }
            },
          ),
          // Overlay with scanning frame
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: kColor1, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Align QR code within frame',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  backgroundColor: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
