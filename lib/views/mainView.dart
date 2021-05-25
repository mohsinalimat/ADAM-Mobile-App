import 'package:adam/constants.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/views/homeView.dart';
import 'package:adam/views/profileView.dart';
import 'package:adam/views/settingsView.dart';
import 'package:adam/views/statsView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  PageController _pageController;

  final _views = [
    HomeView(),
    StatsView(),
    ProfileView(),
    SettingsView(),
  ];

  final _bottomBarItems = [
    BottomNavyBarItem(
      icon: Icon(Icons.home),
      title: Text("Home"),
      activeColor: kPrimaryBlueColor,
      inactiveColor: Colors.grey[400],
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.auto_graph),
      title: Text("Stats"),
      activeColor: kPrimaryBlueColor,
      inactiveColor: Colors.grey[400],
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.person),
      title: Text("Account"),
      activeColor: kPrimaryBlueColor,
      inactiveColor: Colors.grey[400],
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.settings),
      title: Text("Settings"),
      activeColor: kPrimaryBlueColor,
      inactiveColor: Colors.grey[400],
      textAlign: TextAlign.center,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomBarProviders = Provider.of<BottomNavBarProvider>(context);

    return Scaffold(
      body: SizedBox.expand(
          child: PageView(
        controller: _pageController,
        children: _views,
        onPageChanged: (index) => _bottomBarProviders.currentIndex = index,
      )),
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 8.0,
        items: _bottomBarItems,
        selectedIndex: _bottomBarProviders.currentIndex,
        onItemSelected: (index) {
          _bottomBarProviders.currentIndex = index;
          _pageController.jumpToPage(index);
        },
        showElevation: false,
      ),
    );
  }
}
