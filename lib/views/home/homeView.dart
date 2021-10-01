import 'dart:convert';

import 'package:adam/constants.dart';
import 'package:adam/controller/serviceController.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/model/service.dart';
import 'package:adam/model/userData.dart';

import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customHomeServiceCards.dart';
import 'package:adam/widgets/serviceCard.dart';
import 'package:adam/widgets/shimmer_loader_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ServiceController serviceController = ServiceController();
  int _currentIndex = 0;

  List subscribedServices = [];

  void _getSubscribedServicesList() async {
    SubscribedServices value = await serviceController.getSubscribedServices();
    setState(() {
      subscribedServices = List.from(value.subscribedServices);
    });
  }

  // get local user object
  UserData _userData;
  void _getLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map userDataObject = jsonDecode(prefs.getString("userData"));
    UserData userData = UserData.fromJSON(userDataObject);
    setState(() {
      _userData = userData;
    });
  }

  @override
  void initState() {
    _getSubscribedServicesList();
    _getLocalUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    final _bottomBarProviders = Provider.of<BottomNavBarProvider>(context);

    return _userData == null
        ? Center(
            child: CircularProgressIndicator(),
          )
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              // "Hi! ${_firebaseAuth.currentUser.displayName}",
                              "Hi! ${_userData.fullName}",
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
                                backgroundImage: _userData.photo == " "
                                    ? AssetImage('assets/dp.png')
                                    : NetworkImage(_userData.photo),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    "Your Services",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 20.0),
                  FutureBuilder(
                    future: serviceController.getSubscribedServices(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.subscribedServices.length == 0) {
                          return Center(
                            child: Text("No Service Subscribed!"),
                          );
                        } else {
                          return CarouselSlider.builder(
                            itemCount: snapshot.data.subscribedServices.length,
                            itemBuilder: (_, index, i) {
                              return YourServiceCard(
                                serviceIcon: snapshot.data.subscribedServices[index]
                                            ['serviceData']['service_name'] ==
                                        "Instagram Marketing"
                                    ? FontAwesomeIcons.instagram
                                    : snapshot.data.subscribedServices[index]['serviceData']
                                                ['service_name'] ==
                                            "Twitter Marketing"
                                        ? FontAwesomeIcons.twitter
                                        : snapshot.data.subscribedServices[index]['serviceData']
                                                    ['service_name'] ==
                                                "Facebook Marketing"
                                            ? FontAwesomeIcons.facebook
                                            : snapshot.data.subscribedServices[index]
                                                            ['serviceData']
                                                        ['service_name'] ==
                                                    "LinkedIn Marketing"
                                                ? FontAwesomeIcons.linkedin
                                                : snapshot.data.subscribedServices[index]
                                                            ['serviceData']['service_name'] ==
                                                        "Email Marketing"
                                                    ? Icons.mail
                                                    : Icons.sms,
                                serviceTitle:
                                    snapshot.data.subscribedServices[index]
                                        ['serviceData']['service_name'],
                                isPremium: snapshot.data
                                    .subscribedServices[index]['isPremium'],
                                isRunning: snapshot.data
                                    .subscribedServices[index]['isRunning'],
                              );
                            },
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              height: 330.0,
                              onPageChanged: (index, reas) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return Center(child: ShimmerLoaderYourServices());
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  subscribedServices.length == 0
                      ? Center(
                          child: Container(height: 27.0),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: subscribedServices.map((service) {
                            int index = subscribedServices.indexOf(service);
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
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "More Services",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_outline_rounded)),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  FutureBuilder(
                      future: serviceController.getServices(),
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
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
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
