import 'dart:convert';
import 'dart:io';

import 'package:adam/app_routes.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/service_controller.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/icons/drawer_icon.dart';
import 'package:adam/model/service/services_list.dart';
import 'package:adam/model/subscribed_services/subscribed_services_list.dart';
import 'package:adam/model/user.dart';
import 'package:adam/providers/bottom_navbar_provider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/utils/scroll_down_effect.dart';
import 'package:adam/views/home/manage_services_view.dart';
import 'package:adam/views/home/widgets/custom_your_service_card.dart';
import 'package:adam/views/home/widgets/no_service_found.dart';
import 'package:adam/views/home/widgets/service_card.dart';
import 'package:adam/views/home/widgets/shimmer_loader_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  final AnimationController animationController;

  const HomeView({Key key, this.animationController}) : super(key: key);
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

  // subscribed services
  List _subscribedServices = [];
  bool _noSubscribedServices = true;

  // social media services
  List servicesAvailable = [];

  // get local user object
  User _userData;

  // call back refresh
  bool refreshProfile = false;

  // getting image locally
  String _photo;

  @override
  void initState() {
    _getLocalPhoto();
    _servicesSubscribedFuture = serviceController.getSubscribedServices();
    _getServices();
    _getSubscribedServicesList();
    _getLocalUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _themeProvider = Provider.of<ThemeProvider>(context);
    final _bottomBarProviders = Provider.of<BottomNavBarProvider>(context);

    return _userData == null
        ? Center(
            child: JumpingDotsProgressIndicator(),
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
                      children: [
                        InkWell(
                          onTap: () {
                            _bottomBarProviders
                                .toggleDrawer(widget.animationController);
                          },
                          child: CustomPaint(
                            size: DrawerIconPainter.size(_width * 0.07),
                            painter: DrawerIconPainter(
                              color: kPrimaryBlueColor,
                            ),
                          ),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
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
                                backgroundImage: _photo == null
                                    ? AssetImage('assets/dp.png')
                                    : FileImage(File(_photo)),
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
                                services: _subscribedServices,
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
                  _subscribedServices.length == 0
                      ? _noSubscribedServices
                          ? Center(child: ShimmerLoaderYourServices())
                          : NoServiceFoundCard(
                              controller: _controller,
                              animateToIndex: () =>
                                  animateToIndex(4.0, _controller),
                            )
                      : CarouselSlider(
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
                          items: _subscribedServices
                              .map(
                                (e) => YourServiceCard(
                                  serviceIcon: e['serviceData']['service_icon'],
                                  serviceTitle: e['serviceData']
                                      ['service_name'],
                                  isPremium: e['isPremium'],
                                  isRunning: e['isRunning'],
                                ),
                              )
                              .toList(),
                        ),
                  const SizedBox(height: 10.0),
                  _subscribedServices.length == 0
                      ? Center(
                          child: Container(
                              height:
                                  _subscribedServices.length == 0 ? 0.0 : 27.0),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _subscribedServices.map((service) {
                            int index = _subscribedServices.indexOf(service);
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
                  SizedBox(height: _subscribedServices.length == 0 ? 0 : 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "More Services",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, AppRoutes.favorite),
                          icon: Icon(Icons.favorite_outline_rounded)),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  servicesAvailable.length == 0
                      ? Center(
                          child: JumpingDotsProgressIndicator(
                            fontSize: 40.0,
                            color: _themeProvider.darkTheme
                                ? Colors.white
                                : kMediumBlueColor,
                          ),
                        )
                      : ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            servicesAvailable.length,
                            (index) => ServiceCard(
                              service: servicesAvailable[index],
                              refreshFtn: callBack,
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
  }

  // getting list of subscribed services of current user
  Future<void> _getSubscribedServicesList(
      {bool newServiceCheck = false}) async {
    List _cacheServices = await Hive.box('subscribedServices').get('services');
    if (_cacheServices == null || _cacheServices.isEmpty || newServiceCheck) {
      SubscribedServices value = await _servicesSubscribedFuture;
      if (mounted) {
        setState(() {
          if (value.subscribedServices.isEmpty) {
            _noSubscribedServices = true;
          }
          _noSubscribedServices = false;
          _subscribedServices = List.from(value.subscribedServices);
        });
      }
    } else {
      setState(() {
        _noSubscribedServices = false;
        _subscribedServices = List.from(_cacheServices);
      });
    }
  }

  // to referch the services of user
  Future<void> _refreshServices() async {
    await _getSubscribedServicesList(newServiceCheck: true);
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

  void _getLocalPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = prefs.getString('userId');
    String _path = prefs.get('${_userId}dp');
    setState(() {
      _photo = _path;
    });
  }

  callBack(boolVar) {
    if (boolVar) {
      setState(() {
        refreshProfile = boolVar;
        _servicesSubscribedFuture = serviceController.getSubscribedServices();
      });
      _getSubscribedServicesList(newServiceCheck: true);
    }
  }

  // fetching data
  void _getServices() async {
    ServicesList servicesList = await serviceController.getServices();
    if (mounted) {
      setState(() {
        servicesAvailable = List.from(servicesList.services);
      });
    }
  }

  void _getLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map userDataObject = jsonDecode(prefs.getString("userData"));
    User userData = User.fromJSON(userDataObject);
    setState(() {
      _userData = userData;
    });
  }
}
