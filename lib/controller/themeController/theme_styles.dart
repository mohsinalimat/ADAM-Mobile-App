import 'dart:ui';
import 'package:adam/constants.dart';
import 'package:adam/utils/main_imports.dart';
import 'package:flutter/material.dart';

class ThemeStyles {
  static ThemeData themeData(
      bool isDarkTheme, BuildContext buildContext, double fontSize) {
    return isDarkTheme
        ? ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Colors.white,
            ),
            backgroundColor: Colors.grey[900],
            iconTheme: IconThemeData(
              color: Colors.white,
              size: fontSize == 35.0
                  ? 35.0
                  : fontSize == 28.0
                      ? 22.0
                      : 18.0,
            ),
            dividerColor: Colors.white,
            fontFamily: 'Roboto',
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            textTheme: TextTheme(
              headline1: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
              headline2: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize == 28.0
                    ? 18.0
                    : fontSize == 35.0
                        ? 24.0
                        : 15.0,
              ),
              headline6: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize + 5.0,
              ),
              subtitle1: TextStyle(
                fontSize: fontSize == 28.0
                    ? 16.0
                    : fontSize == 35.0
                        ? 22.0
                        : 13.0,
              ),
              subtitle2: TextStyle(
                fontSize: fontSize == 28.0
                    ? 16.0
                    : fontSize == 35.0
                        ? 26.0
                        : 15.0,
              ),
              bodyText1: TextStyle(
                color: Colors.white,
              ),
              bodyText2: TextStyle(
                color: Colors.white,
                fontSize: fontSize == 28.0
                    ? 13.0
                    : fontSize == 35.0
                        ? 18.0
                        : 10.0,
              ),
              caption: TextStyle(
                fontSize: fontSize == 28.0
                    ? 13.0
                    : fontSize == 35.0
                        ? 18.0
                        : 11.0,
              ),
            ).apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.grey,
              brightness: Brightness.dark,
            ).copyWith(secondary: Colors.grey[900]),
          )
        : ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Colors.white,
            ),
            primaryColor: kPrimaryBlueColor,
            backgroundColor: kLightBlueColor,
            iconTheme: IconThemeData(
              color: kPrimaryBlueColor,
              size: fontSize == 35.0
                  ? 35.0
                  : fontSize == 28.0
                      ? 22.0
                      : 18.0,
            ),
            dividerColor: Colors.transparent,
            fontFamily: 'Roboto',
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            textTheme: TextTheme(
              headline1: TextStyle(
                color: kPrimaryBlueColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
              headline2: TextStyle(
                color: kPrimaryBlueColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize == 28.0
                    ? 18.0
                    : fontSize == 35.0
                        ? 24.0
                        : 15.0,
              ),
              headline6: TextStyle(
                color: kPrimaryBlueColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize + 5.0,
              ),
              subtitle1: TextStyle(
                fontSize: fontSize == 28.0
                    ? 16.0
                    : fontSize == 35.0
                        ? 22.0
                        : 13.0,
              ),
              subtitle2: TextStyle(
                fontSize: fontSize == 28.0
                    ? 16.0
                    : fontSize == 35.0
                        ? 26.0
                        : 15.0,
              ),
              bodyText1: TextStyle(
                color: kPrimaryBlueColor,
              ),
              bodyText2: TextStyle(
                color: kPrimaryBlueColor,
                fontSize: fontSize == 28.0
                    ? 13.0
                    : fontSize == 35.0
                        ? 18.0
                        : 10.0,
              ),
              caption: TextStyle(
                fontSize: fontSize == 28.0
                    ? 13.0
                    : fontSize == 35.0
                        ? 18.0
                        : 11.0,
              ),
            ),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.lightBlue,
              brightness: Brightness.light,
            ).copyWith(
              secondary: kPrimaryBlueColor,
            ),
          );
  }
}
