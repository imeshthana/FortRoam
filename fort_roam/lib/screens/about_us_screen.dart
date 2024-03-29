import 'package:flutter/material.dart';
import 'package:fort_roam/components/app_bar1.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:fort_roam/components/items_grid.dart';
import 'package:fort_roam/components/sub_titles.dart';

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
                Container(
                  width: MediaQuery.of(context).size.height * 0.45,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Image.asset(
                      'images/galle_heritage_logo.jpg',
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
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
                                      0.025,
                                ),
                                Center(
                                  child: Text(
                                    'The Living World Heritage Galle Fort to be the most Excellent Cultural Heritage City in Sri Lanka',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    textAlign: TextAlign.center,
                                  ),
                                )
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
                                      0.025,
                                ),
                                Center(
                                  child: Text(
                                    'To conserve Galle Fort as a Historic Cultural Centre and a Site of Archaeological',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SubTitles(subTitle: 'Contact Us'),
                SizedBox(
                  height: 20,
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
                        ContactDetailTile(
                          icon: Icons.email,
                          label: 'Email',
                          value: 'galleheritagefoundation@gmail.com',
                        ),
                        SizedBox(height: 10),
                        ContactDetailTile(
                          icon: Icons.phone,
                          label: 'Phone Number',
                          value: '091 2246784 / 091 3096266',
                        ),
                        SizedBox(height: 10),
                        ContactDetailTile(
                          icon: Icons.location_on,
                          label: 'Address',
                          value: 'No 12, Rampart Street, Fort, Galle',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
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
