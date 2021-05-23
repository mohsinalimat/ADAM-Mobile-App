import 'package:adam/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatefulWidget {
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
  final String errorText;

  const CustomTextField({
    Key key,
    @required this.textEditingController,
    @required this.textInputAction,
    @required this.textInputType,
    this.node,
    @required this.hintText,
    @required this.icon,
    this.isPassword = false,
    this.onChangeFtn,
    this.onEditComplete,
    this.validatorFtn,
    this.onFieldSubmit,
    this.errorText,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPass = true;

  _showPass() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.89,
      child: TextFormField(
        obscureText: widget.isPassword ? showPass : false,
        controller: widget.textEditingController,
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        onChanged: widget.onChangeFtn,
        onEditingComplete: widget.onEditComplete,
        decoration: InputDecoration(
          errorText: widget.errorText,
          prefixIcon: Icon(
            widget.icon,
            color: kPrimaryBlueColor,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: _showPass,
                  icon: Icon(
                    showPass ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                    color: kPrimaryBlueColor,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.all(5.0),
          hintText: widget.hintText,
          hintStyle: kHintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: widget.validatorFtn,
        onFieldSubmitted: widget.onFieldSubmit,
      ),
    );
  }
}
