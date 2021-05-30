import 'dart:ui';
import 'package:adam/constants.dart';
import 'package:flutter/material.dart';

class ThemeStyles {
  static ThemeData themeData(bool isDarkTheme, BuildContext buildContext) {
    return isDarkTheme
        ? ThemeData(
            primarySwatch: Colors.grey,
            primaryColor: Colors.white,
            brightness: Brightness.dark,
            backgroundColor: Colors.grey[900],
            accentColor: Colors.grey[900],
            iconTheme: IconThemeData(color: Colors.white),
            dividerColor: Colors.white,
            fontFamily: 'Roboto',
            textTheme: TextTheme(
              headline1: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
              headline2: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              caption: TextStyle(
                fontSize: 13.0,

                // color: Colors.grey[700],
              ),
            ).apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
          )
        : ThemeData(
            primarySwatch: Colors.lightBlue,
            accentColor: kPrimaryBlueColor,
            primaryColor: kPrimaryBlueColor,
            brightness: Brightness.light,
            backgroundColor: kLightBlueColor,
            iconTheme: IconThemeData(
              color: kPrimaryBlueColor,
            ),
            dividerColor: Colors.transparent,
            fontFamily: 'Roboto',
            textTheme: TextTheme(
              headline1: TextStyle(
                color: kPrimaryBlueColor,
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
              headline2: TextStyle(
                color: kPrimaryBlueColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              bodyText1: TextStyle(
                color: kPrimaryBlueColor,
              ),
              bodyText2: TextStyle(
                color: kPrimaryBlueColor,
                // fontWeight: FontWeight.bold,
              ),
              caption: TextStyle(
                fontSize: 13.0,

                // color: Colors.grey[700],
              ),
            ),
          );
  }
}
