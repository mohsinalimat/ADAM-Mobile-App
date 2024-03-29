import 'package:adam/constants.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditableCustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode node;
  final String labelText;

  final bool isPassword;

  final Function(String) onChangeFtn;
  final Function onEditComplete;
  final Function(String) validatorFtn;
  final Function(String) onFieldSubmit;
  final String errorText;
  final IconData icon;

  const EditableCustomTextField({
    Key key,
    @required this.textEditingController,
    @required this.textInputAction,
    @required this.textInputType,
    @required this.icon,
    this.node,
    this.isPassword = false,
    this.onChangeFtn,
    this.onEditComplete,
    this.validatorFtn,
    this.onFieldSubmit,
    this.errorText,
    this.labelText,
  }) : super(key: key);

  @override
  _EditableCustomTextFieldState createState() =>
      _EditableCustomTextFieldState();
}

class _EditableCustomTextFieldState extends State<EditableCustomTextField> {
  bool showPass = true;

  _showPass() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(color: Colors.grey[500]),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: width,
          // height: 40.0,
          child: TextFormField(
            obscureText: widget.isPassword ? showPass : false,
            controller: widget.textEditingController,
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            onChanged: widget.onChangeFtn,
            onEditingComplete: widget.onEditComplete,
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  _themeProvider.darkTheme ? Colors.black12 : Colors.grey[100],
              errorText: widget.errorText,
              prefixIcon: Hero(
                tag: widget.icon.toString(),
                transitionOnUserGestures: true,
                child: Icon(
                  widget.icon,
                  color: _themeProvider.darkTheme
                      ? Colors.grey
                      : kPrimaryBlueColor,
                ),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: _showPass,
                      icon: Icon(
                        showPass
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: kPrimaryBlueColor,
                        size: 20.0,
                      ),
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
            validator: widget.validatorFtn,
            onFieldSubmitted: widget.onFieldSubmit,
          ),
        ),
      ],
    );
  }
}
