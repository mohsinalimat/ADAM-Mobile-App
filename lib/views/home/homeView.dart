import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:adam/widgets/customHomeServiceCards.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _firebaseAuth = FirebaseAuth.instance;
  int _currentIndex = 0;

  // final _allServices = [
  //   MoreServiceCard(
  //     serviceIcon: Icons.mail,
  //     serviceTitle: "Email Marketing",
  //     premiumAvailable: true,
  //     price: "79/month",
  //   ),
  //   MoreServiceCard(
  //     serviceIcon: FontAwesomeIcons.sms,
  //     serviceTitle: "SMS Marketing",
  //     premiumAvailable: false,
  //     price: "120/month",
  //   ),
  //   MoreServiceCard(
  //     serviceIcon: FontAwesomeIcons.twitter,
  //     serviceTitle: "Twitter Marketing",
  //     premiumAvailable: true,
  //     price: "89/month",
  //   ),
  // ];

  final _yourServices = [
    YourServiceCard(
      isRunning: true,
      serviceIcon: FontAwesomeIcons.instagram,
      serviceTitle: "Instagram Marketing",
      isPremium: true,
    ),
    YourServiceCard(
      serviceIcon: FontAwesomeIcons.sms,
      serviceTitle: "SMS Marketing",
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


  // TODO: Show all services here
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return _themeProvider == null
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
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
                          radius: 35.0,
                          backgroundColor: _themeProvider.darkTheme
                              ? kMediumGreenColor
                              : kLightGreenColor,
                          child: CircleAvatar(
                            radius: 34.0,
                            backgroundColor: _themeProvider.darkTheme
                                ? Colors.grey[800]
                                : Colors.white,
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Your Services",
                    style: Theme.of(context).textTheme.headline1,
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
                      onPageChanged: (index, reas) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _yourServices.map((service) {
                        int index = _yourServices.indexOf(service);
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: _currentIndex == index ? 25.0 : 7.0,
                          height: 7.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            // shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? kMediumBlueColor
                                : _themeProvider.darkTheme
                                    ? Colors.white
                                    : kLightBlueColor.withAlpha(100),
                          ),
                        );
                      }).toList())
                  // SizedBox(
                  //   height: 50.0,
                  // ),
                  // Text(
                  //   "More Services",
                  //   style: kHeadingStyle,
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // CarouselSlider(
                  //   items: _allServices,
                  //   options: CarouselOptions(
                  //       enlargeCenterPage: true,
                  //       viewportFraction: 1,
                  //       height: 330.0,
                  //       autoPlay: true,
                  //       enableInfiniteScroll: false,
                  //       autoPlayInterval: Duration(
                  //         seconds: 3,
                  //       )),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                ],
              ),
            ),
          );
  }
}
