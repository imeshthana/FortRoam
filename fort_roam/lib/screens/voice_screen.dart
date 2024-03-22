import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/items_grid.dart';
import 'package:fort_roam/components/sub_titles.dart';
import '../components/app_bar2.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceScreen extends StatefulWidget {
  VoiceScreen({super.key, required this.data});

  final List<Map<String, dynamic>> data;
  static String id = 'voice_screen';

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  String? text;
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
      // if (place['type']!.toLowerCase().contains(keywords.toLowerCase()) ||
      //     place['subtype']!.toLowerCase().contains(keywords.toLowerCase()) ||
      //     place['title']!.toLowerCase().contains(keywords.toLowerCase())) {
      //   matchingPlaces.add(place);
      // }

      // if (keywords.toLowerCase().contains(place['type']!.toLowerCase()) ||
      //     keywords.toLowerCase().contains(place['subtype']!.toLowerCase()) ||
      //     keywords.toLowerCase().contains(place['title']!.toLowerCase())) {
      //   matchingPlaces.add(place);
      // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kColor1, width: 2.0),
          ),
          child: AvatarGlow(
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
                radius: MediaQuery.of(context).size.height * 0.04,
                child: Icon(
                  Icons.mic,
                  color: iColor,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
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
                    fontSize: MediaQuery.of(context).size.height * 0.0225),
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
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   decoration: BoxDecoration(
            //     color: kColor2,
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.search,
            //         color: Colors.white,
            //         size: 30,
            //       ),
            //       SizedBox(width: 10),
            //       Text(
            //         text,
            //         style: TextStyle(fontSize: 17.5, color: Colors.white),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            if (filteredPlaces.isNotEmpty) ...[
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Expanded(
                child: SingleChildScrollView(
                    child: ItemsGrid(places: filteredPlaces)),
              ),
              SizedBox(
                height: 30,
              )
            ],
            if (filteredPlaces.isEmpty) ...[
              Container(
                margin: EdgeInsets.only(
                    top: 25,
                    left: MediaQuery.of(context).size.height * 0.025,
                    right: MediaQuery.of(context).size.height * 0.025),
                child: Text(
                  'Tap, hold and say where do you want to go...',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              )
            ]
          ],
        ),
      ),
    );
  }
}
