import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassCheckRequirements extends StatelessWidget {
  final bool passCheck;
  final String requirement;

  const PassCheckRequirements(
      {Key key, @required this.passCheck, @required this.requirement})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      children: [
        passCheck
            ? Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
              )
            : Icon(
                Icons.check_circle_outline_rounded,
                color:
                    _themeProvider.darkTheme ? Colors.white : Colors.grey[500],
              ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          requirement,
          style: TextStyle(
              color: passCheck
                  ? Colors.green
                  : _themeProvider.darkTheme
                      ? Colors.white
                      : Colors.grey[500]),
        )
      ],
    );
  }
}
