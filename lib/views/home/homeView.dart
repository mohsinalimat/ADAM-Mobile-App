import 'package:adam/constants.dart';
import 'package:adam/controller/serviceController.dart';
import 'package:adam/controller/themeController/themeProvider.dart';

import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/widgets/customHomeServiceCards.dart';
import 'package:adam/widgets/serviceCard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _firebaseAuth = FirebaseAuth.instance;
  int _currentIndex = 0;

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
                        const SizedBox(width: 10.0),
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
                                            _firebaseAuth.currentUser.photoURL),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "More Services",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      IconButton(
                          onPressed: () {},
                          // onPressed: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => FavoriteView(
                          //               favoriteServices: _fvtServices,
                          //             ))),
                          icon: Icon(Icons.favorite_outline_rounded)),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  FutureBuilder(
                      future: ServiceController().getServices(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.services.length != 0) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.services.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ServiceCard(
                                  service: snapshot.data.services[index],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Text("No Services Found :)"),
                            );
                          }
                        } else {
                          return Center(
                            child: JumpingDotsProgressIndicator(
                              fontSize: 40.0,
                              color: kMediumBlueColor,
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          );
  }
}
