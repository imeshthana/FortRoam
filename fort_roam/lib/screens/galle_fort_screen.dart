import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:fort_roam/components/titles.dart';

class GalleFortScreen extends StatefulWidget {
  const GalleFortScreen(
      {super.key, required this.imageHeroTag, required this.titleHeroTag});

  final UniqueKey imageHeroTag;
  final UniqueKey titleHeroTag;

  @override
  State<GalleFortScreen> createState() => _GalleFortScreenState();
}

class _GalleFortScreenState extends State<GalleFortScreen> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.5);
  }

  Future<void> speakDescription() async {
    String title = "Gall Fort";
    String description =
        "Gall Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Gall. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Gall Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture. With its imposing ramparts, bastions, and intricate urban layout, Gall Fort reflects a unique blend of European design and South Asian traditions, showcasing how different cultures converged through centuries of trade, conquest, and settlement. Spread across approximately 52 hectares, the fort is enclosed by massive granite and coral stone walls that have withstood centuries of monsoon rains, invasions, and even the devastating Indian Ocean tsunami of 2004. Within these protective walls lies a living city, complete with narrow cobblestone streets, quaint Dutch-style villas, churches, mosques, Buddhist temples, and colonial-era administrative buildings. Today, many of these structures have been transformed into boutique hotels, cafes, museums, art galleries, and craft shops, blending history with modern lifestyle. Gall Fort also serves as a cultural hub where locals and visitors can experience Sri Lanka’s diverse heritage. Walking along its ramparts offers panoramic views of the Indian Ocean, while landmarks such as the iconic Gall Lighthouse, the Dutch Reformed Church, the Old Dutch Hospital, and the Maritime Archaeology Museum provide glimpses into its rich past. The fort’s vibrant community, consisting of descendants of Moorish traders, Sinhalese, Tamils, Burghers, and Europeans, adds to its cosmopolitan charm. Beyond its architectural and historical significance, Gall Fort is a place where time seems to slow down. Whether exploring its atmospheric streets, enjoying a sunset over the ramparts, or immersing oneself in its art and cultural festivals, the fort continues to be a symbol of resilience and harmony between past and present.";
    await flutterTts
        .speak("Here is some information about $title. $description");
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 15, right: 5),
        child: FloatingActionButton(
          onPressed: speakDescription,
          child: Icon(Icons.volume_up, color: Colors.white, size: 30.0),
          backgroundColor: kColor1,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      body: Stack(children: [
        Container(
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
                            tag: widget.imageHeroTag,
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
                          tag: widget.titleHeroTag,
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
                      'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture. With its imposing ramparts, bastions, and intricate urban layout, Galle Fort reflects a unique blend of European design and South Asian traditions, showcasing how different cultures converged through centuries of trade, conquest, and settlement.',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Spread across approximately 52 hectares, the fort is enclosed by massive granite and coral stone walls that have withstood centuries of monsoon rains, invasions, and even the devastating Indian Ocean tsunami of 2004. Within these protective walls lies a living city, complete with narrow cobblestone streets, quaint Dutch-style villas, churches, mosques, Buddhist temples, and colonial-era administrative buildings. Today, many of these structures have been transformed into boutique hotels, cafes, museums, art galleries, and craft shops, blending history with modern lifestyle.',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Galle Fort also serves as a cultural hub where locals and visitors can experience Sri Lanka’s diverse heritage. Walking along its ramparts offers panoramic views of the Indian Ocean, while landmarks such as the iconic Galle Lighthouse, the Dutch Reformed Church, the Old Dutch Hospital, and the Maritime Archaeology Museum provide glimpses into its rich past. The fort’s vibrant community, consisting of descendants of Moorish traders, Sinhalese, Tamils, Burghers, and Europeans, adds to its cosmopolitan charm.',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Beyond its architectural and historical significance, Galle Fort is a place where time seems to slow down. Whether exploring its atmospheric streets, enjoying a sunset over the ramparts, or immersing oneself in its art and cultural festivals, the fort continues to be a symbol of resilience and harmony between past and present.',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ]),
    );
  }
}
