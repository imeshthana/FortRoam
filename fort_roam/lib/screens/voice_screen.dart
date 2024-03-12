import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/items_grid.dart';
import 'package:fort_roam/components/sub_titles.dart';
import '../components/app_bar1.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceScreen extends StatefulWidget {
  VoiceScreen({super.key});
  static String id = 'voice_screen';

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  var text = 'Where do you want to go....';
  var isListening = false;
  Color iColor = kColor1;
  Color bColor = Colors.white;
  List<Map<String, String>> filteredPlaces = [];

  SpeechToText speech = SpeechToText();

  void filterPlacesByKeywords(String keywords) {
    keywords = keywords.toLowerCase();
    List<Map<String, String>> matchingPlaces = [];
    for (var place in places) {
      if (keywords.contains(place['type']!) ||
          keywords.contains(place['subtype']!) ||
          keywords.contains(place['title']!.toLowerCase())) {
        matchingPlaces.add(place);
      }
    }
    setState(() {
      filteredPlaces = matchingPlaces;
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
                radius: 30,
                child: Icon(
                  Icons.mic,
                  color: iColor,
                  size: 30,
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
              height: 20,
            ),
            SubTitles(subTitle: 'Find a Place'),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kColor2,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(fontSize: 17.5, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (filteredPlaces.isNotEmpty) ...[
              SizedBox(height: 20.0),
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
                margin: EdgeInsets.only(top: 25, left: 40, right: 40),
                child: Text(
                  'Tap, hold and say where do you want to go...',
                  style: TextStyle(fontSize: 17.5, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
