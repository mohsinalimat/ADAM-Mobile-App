import 'package:adam/constants.dart';
import 'package:adam/controller/darkModeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    @required this.btnWidth,
    @required this.btnHeight,
    this.node,
    @required this.btnOnPressed,
    @required this.btnColor,
    @required this.btnText,
  });
  final double btnWidth;
  final double btnHeight;
  final FocusScopeNode node;
  final Function btnOnPressed;
  final Widget btnText;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: btnColor,
        onPressed: btnOnPressed,
        child: btnText,
      ),
    );
  }
}

class CustomEditBtn extends StatelessWidget {
  final Function onBtnPress;
  final String heroTag;

  const CustomEditBtn({
    Key key,
    this.onBtnPress,
    @required this.heroTag,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: FloatingActionButton(
        heroTag: this.heroTag,
        elevation: 1,
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.grey[900]
            : Colors.white,
        onPressed: onBtnPress,
        mini: true,
        child: Icon(
          Icons.edit,
          color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : kPrimaryBlueColor,
          size: 20.0,
        ),
      ),
    );
  }
}
