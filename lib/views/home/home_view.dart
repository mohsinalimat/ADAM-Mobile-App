import 'dart:convert';

import 'package:adam/constants.dart';
import 'package:adam/controller/serviceController.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/model/service.dart';
import 'package:adam/model/userData.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/utils/scroll_down_effect.dart';
import 'package:adam/views/home/manage_services_view.dart';
import 'package:adam/widgets/customHomeServiceCards.dart';
import 'package:adam/widgets/serviceCard.dart';
import 'package:adam/widgets/shimmer_loader_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // scroll effect
  ScrollController _controller = ScrollController();

  final ServiceController serviceController = ServiceController();
  int _currentIndex = 0;

  // future instance to presist FutureBuilder from calling again and again
  Future _servicesSubscribedFuture;

  List subscribedServices = []; // dummy list to create the dots

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

  bool refreshProfile = false;
  callBack(boolVar) {
    if (boolVar) {
      setState(() {
        refreshProfile = boolVar;
        _servicesSubscribedFuture = serviceController.getSubscribedServices();
      });
      _getSubscribedServicesList();
    }
  }

  @override
  void initState() {
    _servicesSubscribedFuture = serviceController.getSubscribedServices();
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
            controller: _controller,
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
                  Row(
                    children: [
                      Text(
                        "Your Services",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          var value = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ManageServicesView(
                                services: subscribedServices,
                              ),
                            ),
                          );

                          if (value != null && value) {
                            callBack(value);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(Icons.settings),
                        ),
                      ),
                      InkWell(
                        onTap: _refreshServices,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(Icons.refresh_rounded),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  FutureBuilder(
                    future: _servicesSubscribedFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.subscribedServices.length == 0) {
                          return _noServiceFound();
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
                          child: Container(
                              height:
                                  subscribedServices.length == 0 ? 0.0 : 27.0),
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
                  SizedBox(height: subscribedServices.length == 0 ? 0 : 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "More Services",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/favorite'),
                          icon: Icon(Icons.favorite_outline_rounded)),
                    ],
                  ),
                  const SizedBox(height: 10.0),
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
                                  refreshFtn: callBack,
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

  // scroll effect widget if no services are found
  Widget _noServiceFound() {
    return Center(
      child: Container(
        height: 330.0,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No Services Found!",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 8.0),
                const Text("Subscribe a Service to get started!"),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 50.0,
                  child: FloatingActionButton(
                    elevation: 2.5,
                    heroTag: 'noservice',
                    onPressed: () {
                      animateToIndex(4.0, _controller);
                    },
                    child: const Icon(
                      Icons.arrow_downward,
                      size: 25.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // getting list of subscribed services of current user
  Future<void> _getSubscribedServicesList() async {
    SubscribedServices value = await _servicesSubscribedFuture;
    if (mounted) {
      setState(() {
        subscribedServices = List.from(value.subscribedServices);
      });
    }
  }

  // to referch the services of user
  void _refreshServices() async {
    await _getSubscribedServicesList();
    customSnackBar(
      context,
      kSecondaryBlueColor,
      Row(
        children: [
          const Icon(Icons.refresh_rounded, color: Colors.white),
          const SizedBox(width: 5.0),
          const Text("Services has been refreshed!")
        ],
      ),
    );
  }
}