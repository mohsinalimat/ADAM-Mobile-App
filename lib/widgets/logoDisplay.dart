import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LogoDisplay extends StatelessWidget {
  const LogoDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/logo/logoColor.svg",
          height: 40,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          "Uplift your Marketing Game",
          style: TextStyle(
              color:
                  _themeProvider.darkTheme ? Colors.white : kPrimaryBlueColor,
              fontSize: 12.0),
        )
      ],
    );
  }
}
