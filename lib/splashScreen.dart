import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _authCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString("userId");
    if (userId == null) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushNamed(context, '/');
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushNamed(context, '/mainView');
      });
    }
  }

  @override
  void initState() {
    _authCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _themeProvider.darkTheme
              ? [
                  Colors.black,
                  Colors.white.withAlpha(10)
                ]
              : [
                  kMediumGreenColor,
                  kPrimaryBlueColor
                ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/logo/logoWhite.svg',
                      height: 75,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Automated Digital Assistant in Marketing",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                    JumpingDotsProgressIndicator(
                      fontSize: 50.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: -40,
                child: SvgPicture.asset(
                  'assets/logo/logoA.svg',
                  height: 200,
                  color: Colors.white.withAlpha(50),
                ),
              )
            ],
          )),
    );
  }
}
