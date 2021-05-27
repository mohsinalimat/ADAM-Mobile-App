import 'package:adam/constants.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:adam/widgets/yourServiceCard.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatelessWidget {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12.0),
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
                  height: 20.0,
                ),
                Text(
                  "Your Services",
                  style: kHeadingStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
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
                    ],
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
                  height: 10.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MoreServiceCard extends StatelessWidget {
  const MoreServiceCard({
    Key key,
    @required this.serviceIcon,
    @required this.serviceTitle,
    this.premiumAvailable = true,
    this.price,
  }) : super(key: key);
  final IconData serviceIcon;
  final String serviceTitle;
  final bool premiumAvailable;
  final String price;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: 200,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                Icon(
                  serviceIcon,
                  color: kPrimaryBlueColor,
                  size: 40.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  serviceTitle,
                  style: kSubHeadingStyle,
                ),
                Text(
                  "Campaign",
                  style: TextStyle(
                    color: kPrimaryBlueColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Starting from \$$price ",
                        style: TextStyle(
                            color: kPrimaryBlueColor,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: premiumAvailable ? "Premium" : "Standard",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: premiumAvailable
                            ? kLightGreenColor
                            : kLightBlueColor,
                      ),
                    ),
                    TextSpan(
                        text: " Available",
                        style: TextStyle(
                            color: kPrimaryBlueColor,
                            fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CustomButton(
              btnWidth: 150,
              btnHeight: 30.0,
              btnOnPressed: () {},
              btnColor: kPrimaryBlueColor,
              btnText: Text(
                "Subscribe",
                style: kBtnTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
