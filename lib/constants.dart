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
// TextStyle kHintTextStyle =
//     TextStyle(fontSize: 12.0, letterSpacing: 1.1, color: Colors.grey[700]);

const TextStyle kBtnTextStyle =
    TextStyle(color: Colors.white, letterSpacing: 1.2, fontSize: 14.0);

// const TextStyle kHeadingStyle = TextStyle(
//     color: kPrimaryBlueColor, fontWeight: FontWeight.bold, fontSize: 28.0);

// const TextStyle kSubHeadingStyle = TextStyle(
//     color: kPrimaryBlueColor, fontWeight: FontWeight.bold, fontSize: 18.0);

const Widget kLoader = SizedBox(
  height: 25,
  width: 25,
  child: CircularProgressIndicator(
    strokeWidth: 2,
    valueColor: AlwaysStoppedAnimation<Color>(kLightGreenColor),
  ),
);

var paymentSuccessful = Row(
  children: [
    Icon(
      Icons.check_circle,
      color: Colors.green,
    ),
    SizedBox(width: 8),
    Text("Payment Successful!"),
  ],
);

var paymentCanceled = Row(
  children: [
    Icon(
      Icons.cancel,
      color: Colors.red,
    ),
    SizedBox(width: 8),
    Text("Payment Canceled!"),
  ],
);

// API STRIPE KEY
const String apiKey =
    'pk_test_51IP4cYA0otFr5s95f3vXRDX2brIA2URgIykWst0rwxbYZifDk9lY4bMwtHJTE8mdPay2GeLhW2wlmy3WnlyMjk5n00w5VNeT0N';

const String secretKey =
    "sk_test_51IP4cYA0otFr5s95LfrEMzPlF7jRc7NB4Ivj8zUqs2uJIs6yKPGsyMSSMXcZOB4iRzlQZKvQfaWEvPACpi64XX3800ZKcjxiQf";
