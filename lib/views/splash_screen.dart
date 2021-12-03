import 'dart:convert';

import 'package:adam/constants.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/model/user_data.dart';
import 'package:adam/utils/main_imports.dart';
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
    String stringfyJson;
    SharedPreferences pref = await SharedPreferences.getInstance();
    stringfyJson = pref.getString("userData");
    UserData userData;
    if (stringfyJson != null) {
      Map userDataObject = jsonDecode(stringfyJson);
      userData = UserData.fromJSON(userDataObject);
    }

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => userData == null ? LoginView() : Dashboard(),
        ),
      );
    });
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
              ? [Colors.black, Colors.white.withAlpha(10)]
              : [kMediumGreenColor, kPrimaryBlueColor],
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
