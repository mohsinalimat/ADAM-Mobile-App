import 'package:adam/constants.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:adam/widgets/customHomeServiceCards.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatelessWidget {
  final _firebaseAuth = FirebaseAuth.instance;

  final _allServices = [
    MoreServiceCard(
      serviceIcon: Icons.mail,
      serviceTitle: "Email Marketing",
      premiumAvailable: true,
      price: "79/month",
    ),
    MoreServiceCard(
      serviceIcon: FontAwesomeIcons.sms,
      serviceTitle: "SMS Marketing",
      premiumAvailable: false,
      price: "120/month",
    ),
    MoreServiceCard(
      serviceIcon: FontAwesomeIcons.twitter,
      serviceTitle: "Twitter Marketing",
      premiumAvailable: true,
      price: "89/month",
    ),
  ];

  final _yourServices = [
    YourServiceCard(
      isRunning: true,
      serviceIcon: FontAwesomeIcons.instagram,
      serviceTitle: "Instagram Marketing",
      isPremium: true,
    ),
    YourServiceCard(
      serviceIcon: FontAwesomeIcons.facebook,
      serviceTitle: "Facebook Marketing",
    ),
    YourServiceCard(
      isPremium: true,
      serviceIcon: FontAwesomeIcons.linkedin,
      serviceTitle: "LinkedIn Marketing",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogoDisplay(),
                      CircleAvatar(
                        radius: 34.0,
                        backgroundColor: kLightGreenColor,
                        child: CircleAvatar(
                          radius: 32.0,
                          backgroundImage:
                              _firebaseAuth.currentUser.photoURL == null
                                  ? AssetImage('assets/dp.png')
                                  : NetworkImage(
                                      _firebaseAuth.currentUser.photoURL,
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Your Services",
                  style: kHeadingStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                CarouselSlider(
                  items: _yourServices,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    height: 330.0,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  "More Services",
                  style: kHeadingStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                CarouselSlider(
                  items: _allServices,
                  options: CarouselOptions(
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      height: 330.0,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      autoPlayInterval: Duration(
                        seconds: 3,
                      )),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
