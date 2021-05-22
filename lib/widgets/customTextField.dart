import 'package:adam/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode node;

  final String hintText;
  final bool isPassword;
  final IconData icon;

  final Function(String) onChangeFtn;
  final Function onEditComplete;
  final Function(String) validatorFtn;
  final Function(String) onFieldSubmit;

  const CustomTextField({
    Key key,
    @required this.textEditingController,
    @required this.textInputAction,
    @required this.textInputType,
    @required this.node,
    @required this.hintText,
    @required this.icon,
    this.isPassword = false,
    this.onChangeFtn,
    this.onEditComplete,
    this.validatorFtn,
    this.onFieldSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.89,
      child: TextFormField(
        obscureText: isPassword,
        controller: textEditingController,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        onChanged: onChangeFtn,
        onEditingComplete: onEditComplete,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kPrimaryBlueColor,
          ),
          contentPadding: const EdgeInsets.all(5.0),
          hintText: hintText,
          hintStyle: kHintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: validatorFtn,
        onFieldSubmitted: onFieldSubmit,
      ),
    );
  }
}
