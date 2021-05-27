import 'package:adam/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
