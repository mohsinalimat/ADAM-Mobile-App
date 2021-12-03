import 'package:adam/constants.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';

class AppInfo extends StatelessWidget {
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
                  Colors.white.withAlpha(10),
                ]
              : [
                  kMediumGreenColor,
                  kPrimaryBlueColor,
                ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(child: Container()),
                  SvgPicture.asset('assets/logo/logoWhite.svg', height: 75),
                  SizedBox(height: 10.0),
                  Text(
                    "Automated Digital Assistant in Marketing",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    "Version 0.0.1",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withAlpha(150),
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 7.0),
                  Text(
                    "All Right Reserved \u00a9 2021 ADAM.app",
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(flex: 2, child: Container()),
                  TextButton(
                    onPressed: () => LaunchReview.launch(
                      androidAppId: "com.hmz.al_quran",
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.googlePlay,
                          color: _themeProvider.darkTheme
                              ? Colors.white
                              : Colors.blue,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "Rate & Feedback",
                          style: TextStyle(
                            color: _themeProvider.darkTheme
                                ? Colors.white
                                : Colors.blue,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
