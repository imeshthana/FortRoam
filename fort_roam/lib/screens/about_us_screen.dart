import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar1.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/sub_titles.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});
  static String id = 'about_us_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: CustomNavigationBar(),
      appBar: CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                SubTitles(subTitle: 'About Us'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Center(
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: kColor3,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                Text(
                                  'Our Vision',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                Center(
                                  child: Text(
                                    '"To create a smart, user-friendly mobile platform that enriches the cultural and historical journey of Galle Fort, making it a globally recognized, accessible, and immersive heritage site."',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: kColor3,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                Text(
                                  'Our Mission',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                Center(
                                  child: Text(
                                    '"To build a mobile app that makes exploring Galle Fort easier and more enjoyable. It offers simple navigation, useful insights, and cultural stories while connecting visitors with local businesses creating memorable experiences and supporting the community."',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: kColor3,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                Text(
                                  'Our Privacy Policy',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final Uri url = Uri.parse(
                                          'https://fortroamweb.onrender.com/privacy-policy');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url,
                                            mode:
                                                LaunchMode.externalApplication);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text(
                                      'View Privacy Policy',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                // SubTitles(subTitle: 'Contact Us'),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: kColor3,
                //     borderRadius: BorderRadius.circular(15.0),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Column(
                //       children: [
                //         ContactDetailTile(
                //           icon: Icons.email,
                //           label: 'Email',
                //           value: 'fortroam@gmail.com',
                //         ),
                //         SizedBox(height: 10),
                //         ContactDetailTile(
                //           icon: Icons.phone,
                //           label: 'Phone Number',
                //           value: '091 2246784 / 091 3096266',
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 40,
                // ),
                SubTitles(subTitle: 'Developed By'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.025,
                      ),
                      width: MediaQuery.of(context).size.height * 0.12,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Image.asset(
                        'images/quadrabytes.png',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.025,
                      ),
                      width: MediaQuery.of(context).size.height * 0.12,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Image.asset(
                        'images/ruhuna_logo.jpg',
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.height * 0.16,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Image.asset(
                        'images/efac_logo.jpg',
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Container(
                    decoration: BoxDecoration(
                      color: kColor3,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            'A Project of',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Center(
                            child: Text(
                              'Department of Computer Engineering',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Center(
                            child: Text(
                              'Faculty of Engineering',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Center(
                            child: Text(
                              'University of Ruhuna',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactDetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ContactDetailTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }
}
