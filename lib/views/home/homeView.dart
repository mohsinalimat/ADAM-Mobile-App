import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/widgets/customHomeServiceCards.dart';
import 'package:adam/widgets/serviceCard.dart';
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
      isPremium: true,
      serviceIcon: FontAwesomeIcons.linkedin,
      serviceTitle: "LinkedIn Marketing",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    final _bottomBarProviders = Provider.of<BottomNavBarProvider>(context);

    return _themeProvider == null
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Hi! ${_firebaseAuth.currentUser.displayName}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const Text(
                              "Good day!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(width: 10.0),
                        CircleAvatar(
                          radius: 32.0,
                          backgroundColor: _themeProvider.darkTheme
                              ? kMediumGreenColor
                              : kLightGreenColor,
                          child: CircleAvatar(
                            radius: 31.0,
                            backgroundColor: _themeProvider.darkTheme
                                ? Colors.grey[800]
                                : Colors.white,
                            child: GestureDetector(
                              onTap: () {
                                _bottomBarProviders.currentIndex = 3;
                              },
                              child: CircleAvatar(
                                radius: 29.0,
                                backgroundImage:
                                    _firebaseAuth.currentUser.photoURL == " "
                                        ? const AssetImage('assets/dp.png')
                                        : NetworkImage(
                                            _firebaseAuth.currentUser.photoURL,
                                          ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Your Services",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CarouselSlider.builder(
                    itemCount: _yourServices.length,
                    itemBuilder: (context, index, i) => _yourServices[index],
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
                  const SizedBox(
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: _currentIndex == index
                                ? kMediumBlueColor
                                : _themeProvider.darkTheme
                                    ? Colors.white
                                    : kLightBlueColor.withAlpha(100),
                          ),
                        );
                      }).toList()),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "More Services",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _services.length,
                    itemBuilder: (context, i) => _services[i],
                  ),
                ],
              ),
            ),
          );
  }

  final _services = [
    ServiceCard(
      serviceIcon: FontAwesomeIcons.facebookSquare,
      serviceName: "Facebook Marketing",
      serviceDescription:
          "Facebook marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "119",
      gradientColors: [
        Color(0xff3a5794),
        kMediumBlueColor,
      ],
    ),
    ServiceCard(
      serviceIcon: FontAwesomeIcons.twitter,
      serviceName: "Twitter Marketing",
      serviceDescription:
          "Twitter marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "149",
      gradientColors: [
        kMediumBlueColor,
        kLightBlueColor,
      ],
    ),
    ServiceCard(
      serviceIcon: FontAwesomeIcons.instagram,
      serviceName: "Instagram Marketing",
      serviceDescription:
          "Instagram marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "139",
      gradientColors: [
        Color(0xfff6d371),
        Color(0xfff27a1d),
        Color(0xffcf2872),
        Color(0xff912eb9),
        Color(0xff4d58ce),
      ],
    ),
    ServiceCard(
      serviceIcon: FontAwesomeIcons.linkedinIn,
      serviceName: "LinkedIn Marketing",
      serviceDescription:
          "LinkedIn marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "99",
      gradientColors: [
        Color(0xff0073af),
        kLightBlueColor,
      ],
    ),
    ServiceCard(
      serviceIcon: Icons.mail,
      serviceName: "Email Marketing",
      serviceDescription:
          "Email marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "179",
      gradientColors: [
        kSecondaryBlueColor,
        kMediumGreenColor,
      ],
    ),
    ServiceCard(
      serviceIcon: Icons.sms,
      serviceName: "SMS Marketing",
      serviceDescription:
          "SMS marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "169",
      gradientColors: [
        kMediumGreenColor,
        kMediumBlueColor,
      ],
    ),
  ];
}
