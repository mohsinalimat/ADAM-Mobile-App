import 'package:adam/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          height: 40.0,
          child: TextFormField(
            obscureText: widget.isPassword ? showPass : false,
            controller: widget.textEditingController,
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            onChanged: widget.onChangeFtn,
            onEditingComplete: widget.onEditComplete,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                errorText: widget.errorText,
                prefixIcon: Hero(
                  tag: widget.icon.toString(),
                  child: Icon(
                    widget.icon,
                    color: kPrimaryBlueColor,
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
                )),
            validator: widget.validatorFtn,
            onFieldSubmitted: widget.onFieldSubmit,
          ),
        ),
      ],
    );
  }
}
