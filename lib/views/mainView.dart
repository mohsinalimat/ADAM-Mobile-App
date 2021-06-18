import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/notifications/push_notifications.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/views/home/homeView.dart';
import 'package:adam/views/mydrawer.dart';
import 'package:adam/views/profile/profileView.dart';
import 'package:adam/views/settings/settingsView.dart';
import 'package:adam/views/stats/statsView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 250);
  static const double maxSlide = 280;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  AnimationController _animationController;
  bool _canBeDragged = false;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
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

  // void _getToken() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String userNotificationToken = sharedPreferences.getString("notifyToken");
  //   if (userNotificationToken != null) {
  //     print("TOKEN ALREADY THERE!");
  //   } else {
  //     print("NEW TOKEN HAS BEEN GENERATED!");
  //     userNotificationToken = await _firebaseMessaging.getToken();
  //     sharedPreferences.setString("notifyToken", userNotificationToken);
  //     FirebaseFirestore.instance
  //         .collection("notificationsToken")
  //         .doc(_firebaseAuth.currentUser.uid)
  //         .set({
  //       "token": userNotificationToken,
  //     });
  //   }
  // }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: _MainViewState.toggleDuration,
    );
    _storingUserIdinLocalStoraget();
    // _getToken();
    // Future.delayed(Duration(seconds: 3), () {
    //   pushNotificationsManager.init();
    // });

    super.initState();
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  void toggleDrawer() => _animationController.isCompleted ? close() : open();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomBarProviders = Provider.of<BottomNavBarProvider>(context);
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double animValue = _animationController.value;
            final slideAmount = maxSlide * animValue;
            final contentScale = 1.0 - (0.3 * animValue);
            return Stack(
              children: <Widget>[
                MyDrawer(),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slideAmount)
                    ..scale(contentScale, contentScale),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _animationController.isCompleted ? close : null,
                    child: child,
                  ),
                ),
              ],
            );
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            child: Scaffold(
              appBar: _bottomBarProviders.currentIndex == 1
                  ? AppBar(
                      leading: Container(),
                      leadingWidth: 10.0,
                      title: const Text("Stats & Analysis"),
                    )
                  : _bottomBarProviders.currentIndex == 2
                      ? AppBar(
                          leading: Container(),
                          leadingWidth: 10.0,
                          title: const Text("Settings"),
                        )
                      : null,
              body: SafeArea(
                  child: Stack(
                children: [
                  _views[_bottomBarProviders.currentIndex],
                  _bottomBarProviders.currentIndex == 0
                      ? Positioned(
                          top: 20,
                          left: 10,
                          child: IconButton(
                            onPressed: () => toggleDrawer(),
                            icon: SvgPicture.asset(
                              'assets/menu.svg',
                              color: _themeProvider.darkTheme
                                  ? Colors.white
                                  : kPrimaryBlueColor,
                            ),
                          ),
                        )
                      : Container(),
                ],
              )),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _themeProvider.darkTheme
                      ? Colors.grey[900]
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: const Offset(0, -1),
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
                            onPressed: () =>
                                _bottomBarProviders.currentIndex = i,
                            icon: i == 1
                                ? SvgPicture.asset(
                                    'assets/stats.svg',
                                    height:
                                        _bottomBarProviders.currentIndex == i
                                            ? 24
                                            : 22,
                                    color: _bottomBarProviders.currentIndex == i
                                        ? _themeProvider.darkTheme
                                            ? Colors.white
                                            : kPrimaryBlueColor
                                        : Colors.grey[400],
                                  )
                                : Icon(
                                    _bottomIcons[i],
                                    size: _bottomBarProviders.currentIndex == i
                                        ? 28.0
                                        : 25.0,
                                    color: _bottomBarProviders.currentIndex == i
                                        ? _themeProvider.darkTheme
                                            ? Colors.white
                                            : kPrimaryBlueColor
                                        : Colors.grey[400],
                                  ),
                          ),
                          _bottomBarProviders.currentIndex == i
                              ? const NavBarBottomItemDot()
                              : Container()
                        ],
                      ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _bottomBarProviders.currentIndex = 3,
                          icon: CircleAvatar(
                            backgroundImage:
                                _firebaseAuth.currentUser.photoURL == " "
                                    ? const AssetImage('assets/dp.png')
                                    : NetworkImage(
                                        _firebaseAuth.currentUser.photoURL),
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
          ),
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Exit Application",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline1.fontSize,
                color: Provider.of<ThemeProvider>(context).darkTheme
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            content: const Text(
              "Are You Sure?",
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.red,
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
}

class NavBarBottomItemDot extends StatelessWidget {
  const NavBarBottomItemDot();
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return WidgetAnimator(
      child: Container(
        height: 5.0,
        width: 5.0,
        decoration: BoxDecoration(
          color: _themeProvider.darkTheme ? Colors.white : kPrimaryBlueColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
