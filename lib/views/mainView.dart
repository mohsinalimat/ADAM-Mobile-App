import 'package:adam/constants.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/views/homeView.dart';
import 'package:adam/views/profileView.dart';
import 'package:adam/views/settingsView.dart';
import 'package:adam/views/statsView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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

  @override
  Widget build(BuildContext context) {
    final _bottomBarProviders = Provider.of<BottomNavBarProvider>(context);

    return Scaffold(
      body: _views[_bottomBarProviders.currentIndex],
      floatingActionButton: _bottomBarProviders.currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomSheet: Container(
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
                    icon: Icon(
                      _bottomIcons[i],
                      size: _bottomBarProviders.currentIndex == i ? 28.0 : 23.0,
                      color: _bottomBarProviders.currentIndex == i
                          ? kPrimaryBlueColor
                          : Colors.grey[400],
                    ),
                  ),
                  _bottomBarProviders.currentIndex == i
                      ? Container(
                          height: 5.0,
                          width: 5.0,
                          decoration: BoxDecoration(
                            color: kPrimaryBlueColor,
                            shape: BoxShape.circle,
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
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser.photoURL),
                  ),
                ),
                _bottomBarProviders.currentIndex == 3
                    ? Container(
                        height: 5.0,
                        width: 5.0,
                        decoration: BoxDecoration(
                          color: kPrimaryBlueColor,
                          shape: BoxShape.circle,
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
    );
  }
}
