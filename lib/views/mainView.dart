import 'dart:io';

import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/constants.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/views/homeView.dart';
import 'package:adam/views/phoneVerificationView.dart';
import 'package:adam/views/profileView.dart';
import 'package:adam/views/settingsView.dart';
import 'package:adam/views/statsView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _views = [
    HomeView(),
    StatsView(),
    SettingsView(),
    ProfileView(),
  ];

  final _bottomIcons = [
    Icons.home,
    // "assets/stats.svg",
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomBarProviders = Provider.of<BottomNavBarProvider>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _views[_bottomBarProviders.currentIndex],
        floatingActionButton: _bottomBarProviders.currentIndex == 0
            ? FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, "/services"),
                child: Icon(Icons.add),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8.0),
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
                                  ? 28.0
                                  : 23.0,
                              color: _bottomBarProviders.currentIndex == i
                                  ? kPrimaryBlueColor
                                  : Colors.grey[400],
                            )
                          : Icon(
                              _bottomIcons[i],
                              size: _bottomBarProviders.currentIndex == i
                                  ? 28.0
                                  : 23.0,
                              color: _bottomBarProviders.currentIndex == i
                                  ? kPrimaryBlueColor
                                  : Colors.grey[400],
                            ),
                    ),
                    _bottomBarProviders.currentIndex == i
                        ? WidgetAnimator(
                            child: Container(
                              height: 5.0,
                              width: 5.0,
                              decoration: BoxDecoration(
                                color: kPrimaryBlueColor,
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
                              color: kPrimaryBlueColor,
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
        // bottomNavigationBar: BottomNavigationBar(
        //   items: _bottomNavBar,
        //   currentIndex: _bottomBarProviders.currentIndex,
        //   onTap: (index) => _bottomBarProviders.currentIndex = index,
        //   selectedItemColor: kPrimaryBlueColor,
        //   unselectedItemColor: Colors.grey[400],
        //   elevation: 0.0,
        //   showSelectedLabels: false,
        //   selectedIconTheme: IconThemeData(size: 30.0),
        // ),
        // bottomNavigationBar: BottomNavyBar(
        //   items: _bottomBarItems,
        //   selectedIndex: _bottomBarProviders.currentIndex,
        //   onItemSelected: (index) => _bottomBarProviders.currentIndex = index,
        //   showElevation: false,
        // ),
      ),
    );
  }
}
