import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/darkModeController/themeProvider.dart';
import 'package:adam/notifications/push_notifications.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/views/home/homeView.dart';
import 'package:adam/views/profile/profileView.dart';
import 'package:adam/views/settings/settingsView.dart';
import 'package:adam/views/stats/statsView.dart';
import 'package:adam/widgets/expandableFabBtn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  PushNotificationsManager pushNotificationsManager =
      PushNotificationsManager();

  final _views = [
    HomeView(),
    StatsView(),
    SettingsView(),
    ProfileView(),
  ];

  final _bottomIcons = [
    Icons.home,
    Icons.auto_graph,
    Icons.settings,
  ];

  void _storingUserIdinLocalStoraget() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("userId") == null) {
      pref.setString("userId", _firebaseAuth.currentUser.uid);
      print("ID STORED: ${_firebaseAuth.currentUser.uid}");
    } else {
      print("ID ALREADY STORED: ${pref.getString("userId")}");
    }
  }

  void _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userNotificationToken = sharedPreferences.getString("notifyToken");
    if (userNotificationToken != null) {
      print("TOKEN ALREADY THERE!");
    } else {
      print("NEW TOKEN HAS BEEN GENERATED!");
      userNotificationToken = await _firebaseMessaging.getToken();
      sharedPreferences.setString("notifyToken", userNotificationToken);
      FirebaseFirestore.instance
          .collection("notificationsToken")
          .doc(_firebaseAuth.currentUser.uid)
          .set({
        "token": userNotificationToken,
      });
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text(
              "Exit Application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Text("Are You Sure?"),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.red[700],
                  ),
                ),
                onPressed: () {
                  // exit(0);
                  SystemNavigator.pop();
                },
              ),
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    _storingUserIdinLocalStoraget();
    // _getToken();
    // Future.delayed(Duration(seconds: 3), () {
    //   pushNotificationsManager.init();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomBarProviders = Provider.of<BottomNavBarProvider>(context);
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _views[_bottomBarProviders.currentIndex],
        floatingActionButton: _bottomBarProviders.currentIndex == 0
            ? WidgetAnimator(
                child: ExpandableFab(
                  distance: 85.0,
                  children: [
                    ActionButton(
                      icon: Icon(Icons.add),
                      onPressed: () =>
                          Navigator.pushNamed(context, "/services"),
                    ),
                    ActionButton(
                      icon: Icon(Icons.history),
                      onPressed: () =>
                          Navigator.pushNamed(context, "/subscriptionHistory"),
                    ),
                    ActionButton(
                      icon: Icon(Icons.chat),
                      onPressed: () => Navigator.pushNamed(context, "/chat"),
                    ),
                  ],
                ),
              )
            : null,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _themeProvider.darkTheme ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -1),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < _views.length - 1; i++)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _bottomBarProviders.currentIndex = i,
                      icon: i == 1
                          ? SvgPicture.asset(
                              'assets/stats.svg',
                              height: _bottomBarProviders.currentIndex == i
                                  ? 24.0
                                  : 22.0,
                              color: _bottomBarProviders.currentIndex == i
                                  ? _themeProvider.darkTheme
                                      ? Colors.white
                                      : kPrimaryBlueColor
                                  : Colors.grey[400],
                            )
                          : Icon(
                              _bottomIcons[i],
                              size: _bottomBarProviders.currentIndex == i
                                  ? 25.0
                                  : 23.0,
                              color: _bottomBarProviders.currentIndex == i
                                  ? _themeProvider.darkTheme
                                      ? Colors.white
                                      : kPrimaryBlueColor
                                  : Colors.grey[400],
                            ),
                    ),
                    _bottomBarProviders.currentIndex == i
                        ? WidgetAnimator(
                            child: Container(
                              height: 5.0,
                              width: 5.0,
                              decoration: BoxDecoration(
                                color: _themeProvider.darkTheme
                                    ? Colors.white
                                    : kPrimaryBlueColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _bottomBarProviders.currentIndex = 3,
                    icon: CircleAvatar(
                      backgroundImage: _firebaseAuth.currentUser.photoURL ==
                              null
                          ? AssetImage('assets/dp.png')
                          : NetworkImage(_firebaseAuth.currentUser.photoURL),
                    ),
                  ),
                  _bottomBarProviders.currentIndex == 3
                      ? WidgetAnimator(
                          child: Container(
                            height: 5.0,
                            width: 5.0,
                            decoration: BoxDecoration(
                              color: _themeProvider.darkTheme
                                  ? Colors.white
                                  : kPrimaryBlueColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
