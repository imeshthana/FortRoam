import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';
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
  var text = 'Say Something';
  var isListening = false;
  Color iColor = kColor1;
  Color bColor = Colors.white;

  SpeechToText speech = SpeechToText();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Center(child: Text(text, style: TextStyle(fontSize: 30))),
          ],
        ),
      ),
    );
  }
}
