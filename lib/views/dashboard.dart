import 'package:adam/animations/bottom_animation.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/icons/graph_icon.dart';
import 'package:adam/providers/bottom_navbar_provider.dart';
import 'package:adam/views/home/home_view.dart';
import 'package:adam/views/custom_drawer.dart';
import 'package:adam/views/profile/profile_view.dart';
import 'package:adam/views/settings/settings_view.dart';
import 'package:adam/views/stats/stats_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 250);
  static const double maxSlide = 280;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  AnimationController _animationController;
  bool _canBeDragged = false;

  Widget _views(int index) {
    if (index == 0) {
      return HomeView(animationController: _animationController);
    } else if (index == 1) {
      return StatsView();
    } else if (index == 2) {
      return SettingsView();
    } else {
      return ProfileView();
    }
  }

  final _bottomIcons = [
    Icons.home,
    Icons.graphic_eq,
    Icons.settings,
    Icons.person,
  ];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: _DashboardState.toggleDuration,
    );
    super.initState();
  }

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
                CustomDrawer(),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slideAmount)
                    ..scale(contentScale, contentScale),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _animationController.isCompleted
                        ? _animationController.reverse
                        : null,
                    child: child,
                  ),
                ),
              ],
            );
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
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
              body: SafeArea(child: _views(_bottomBarProviders.currentIndex)),
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
                    for (int i = 0; i < 4; i++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () =>
                                _bottomBarProviders.currentIndex = i,
                            icon: i == 1
                                ? CustomPaint(
                                    size: GraphIconPainter.size(
                                        _bottomBarProviders.currentIndex == i
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06),
                                    painter: GraphIconPainter(
                                      color:
                                          _bottomBarProviders.currentIndex == i
                                              ? _themeProvider.darkTheme
                                                  ? Colors.white
                                                  : kPrimaryBlueColor
                                              : Colors.grey[400],
                                    ),
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
      _animationController.reverse();
    } else {
      _animationController.forward();
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
