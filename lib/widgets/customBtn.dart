import 'package:flutter/material.dart';

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
  final String btnText;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: btnColor,
        onPressed: btnOnPressed,
        child: Text(
          btnText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.2,
            fontSize: MediaQuery.of(context).size.height * 0.022,
          ),
        ),
      ),
    );
  }
}
