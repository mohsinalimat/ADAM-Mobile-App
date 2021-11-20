import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class CustomLoader extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GlowingProgressIndicator(
      duration: Duration(milliseconds: 700),
      child: SvgPicture.asset(
        'assets/logo/logoA.svg',
        height: 70,
        color: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.white.withAlpha(150)
            : null,
      ),
    );
  }
}
