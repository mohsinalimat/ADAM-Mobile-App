import 'package:flutter/material.dart';

// URLs
const String kHerokuURL = "https://adam-web-api.herokuapp.com";
const String kLocalHostIP = "http://10.113.62.78";
const String kAzureIP = "http://13.72.68.224";

// Colors
const Color kLightGreenColor = Color(0xff5bdb5b);
const Color kMediumGreenColor = Color(0xff49d695);
const Color kLightBlueColor = Color(0xff3bbffb);
const Color kMediumBlueColor = Color(0xff0179d4);
const Color kSecondaryBlueColor = Color(0xff0d569e);
const Color kPrimaryBlueColor = Color(0xff114b8c);

const TextStyle kBtnTextStyle =
    TextStyle(color: Colors.white, letterSpacing: 1.2, fontSize: 14.0);

const TextStyle kBtnSubscribedTextStyle =
    TextStyle(color: Colors.grey, letterSpacing: 1.2, fontSize: 14.0);

const Widget kLoader = SizedBox(
  height: 25,
  width: 25,
  child: CircularProgressIndicator(
    strokeWidth: 2,
    valueColor: AlwaysStoppedAnimation<Color>(kLightGreenColor),
  ),
);

const Widget kLoaderWhite = SizedBox(
  height: 25,
  width: 25,
  child: CircularProgressIndicator(
    strokeWidth: 2,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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

/// Dummy Data
const List<String> dataName = [
  "Muhammad Hamza",
  "Usman Yaseen",
  "Raheel Siq",
  "Xain Shabir",
  "Baig Shaib",
  "Khan Khan",
  "Muhammad Hamza",
  "Usman Yaseen",
  "Raheel Siq",
  "Xain Shabir",
  "Baig Shaib",
  "Khan Khan",
  "Muhammad Hamza",
  "Usman Yaseen",
  "Raheel Siq",
  "Xain Shabir",
  "Baig Shaib",
  "Khan Khan",
  "Muhammad Hamza",
  "Usman Yaseen",
  "Raheel Siq",
  "Xain Shabir",
  "Baig Shaib",
  "Khan Khan",
];

const List<String> dataUsername = [
  "@mhmzdev",
  "@uyaseen",
  "@raweheel",
  "@zainXzian",
  "@baigbaigbaig",
  "@gkhang",
  "@mhmzdev",
  "@uyaseen",
  "@raweheel",
  "@zainXzian",
  "@baigbaigbaig",
  "@gkhang",
  "@mhmzdev",
  "@uyaseen",
  "@raweheel",
  "@zainXzian",
  "@baigbaigbaig",
  "@gkhang",
  "@mhmzdev",
  "@uyaseen",
  "@raweheel",
  "@zainXzian",
  "@baigbaigbaig",
  "@gkhang",
];

// in app images
const List<String> kGuideImages = [
  "https://user-images.githubusercontent.com/43790152/135808020-50578291-922e-43b4-9b14-c93a3111a4cb.png",
  "https://user-images.githubusercontent.com/43790152/135808016-6aad383b-8222-4106-a293-3a2736fa81b4.png",
  "https://user-images.githubusercontent.com/43790152/135808013-c7d4d626-8e4a-470c-af8f-1cede0695d77.png",
  "https://user-images.githubusercontent.com/43790152/135808009-4f59d1bc-95df-4c03-85f6-2955ff5fe730.png",
  "https://user-images.githubusercontent.com/43790152/135808005-3a8bafbc-a02e-4e31-a485-df667c60bb36.png",
  "https://user-images.githubusercontent.com/43790152/135807998-14ec5b9f-5d47-43c7-8a1f-7a73fb34e3ae.png",
  "https://user-images.githubusercontent.com/43790152/135807995-9db019d2-d91f-4b6d-bb2d-3701e374ad38.png",
  "https://user-images.githubusercontent.com/43790152/135807991-02866c82-7926-4522-99d0-b27ec6352f10.png",
  "https://user-images.githubusercontent.com/43790152/135807987-266c64e7-a9e0-4ab0-8d9f-b35016a1a9e4.png",
  "https://user-images.githubusercontent.com/43790152/135807994-d3373936-3600-4776-bc56-210dd3ff0f94.png",
];
