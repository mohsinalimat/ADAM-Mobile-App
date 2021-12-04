import 'package:adam/constants.dart';
import 'package:adam/utils/main_imports.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function onPressed;
  const CustomBackButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(
          Icons.arrow_back,
          color: _theme.darkTheme ? Colors.white : kPrimaryBlueColor,
        ),
      ),
    );
  }
}
