import 'package:adam/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogoDisplay(),
                      CircleAvatar(
                        radius: 34.0,
                        backgroundColor: kLightGreenColor,
                        child: CircleAvatar(
                          radius: 32.0,
                          backgroundImage:
                              NetworkImage(_firebaseAuth.currentUser.photoURL),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoDisplay extends StatelessWidget {
  const LogoDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/logo/logoColor.svg",
          height: 40.0,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          "Uplift your Marketing Game",
          style: TextStyle(color: kPrimaryBlueColor, fontSize: 12.0),
        )
      ],
    );
  }
}
