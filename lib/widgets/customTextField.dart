import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode node;

  final String hintText;
  final bool isPassword;
  final IconData icon;
  final Color iconColor;
  final Color passIconColor;

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
    this.iconColor,
    this.passIconColor,
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
  FocusNode _node = FocusNode();
  _showPass() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      width: width * 0.89,
      child: TextFormField(
        // focusNode: widget.node == null ? _node : widget.node,
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
            color: widget.iconColor != null
                ? widget.iconColor
                : _themeProvider.darkTheme
                    ? Colors.white
                    : kPrimaryBlueColor,
            // color: widget.iconColor,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: _showPass,
                  icon: Icon(
                    showPass ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                    color: widget.passIconColor != null
                        ? widget.passIconColor
                        : _themeProvider.darkTheme
                            ? Colors.white70
                            : kPrimaryBlueColor,
                    size: 20.0,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.all(5.0),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.caption,
          fillColor:
              _themeProvider.darkTheme ? Colors.black12 : Colors.grey[200],
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[700]),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[700]),
          ),
        ),
        validator: widget.validatorFtn,
        onFieldSubmitted: widget.onFieldSubmit,
      ),
    );
  }
}
