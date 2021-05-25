import 'package:flutter/material.dart';

// Colors
const Color kLightGreenColor = Color(0xff5bdb5b);
const Color kMediumGreenColor = Color(0xff49d695);
const Color kLightBlueColor = Color(0xff3bbffb);
const Color kMediumBlueColor = Color(0xff0179d4);
const Color kSecondaryBlueColor = Color(0xff0d569e);
const Color kPrimaryBlueColor = Color(0xff114b8c);

// paths
const String kLogoColor = 'assets/logo/logo/logoColor.svg';
const String kLogoWhite = 'assets/logo/logoWhite.svg';
const String kLogoBlack = 'assets/logo/logoBlack.svg';
const String kLogoA = 'assets/logo/logoA.svg';

// text styles
TextStyle kHintTextStyle =
    TextStyle(fontSize: 12.0, letterSpacing: 1.1, color: Colors.grey[700]);

const TextStyle kBtnTextStyle =
    TextStyle(color: Colors.white, letterSpacing: 1.2, fontSize: 14.0);

const Widget kLoader = SizedBox(
  height: 25,
  width: 25,
  child: CircularProgressIndicator(
    strokeWidth: 2,
    valueColor: AlwaysStoppedAnimation<Color>(kLightGreenColor),
  ),
);
