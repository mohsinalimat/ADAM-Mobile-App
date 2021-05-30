import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/darkModeController/themeProvider.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChangeEmailView extends StatefulWidget {
  final Function(bool) refreshEmailCallBack;
  final String fullName;
  final String updatedEmail;
  final Map<String, Object> updatedData;

  const ChangeEmailView({
    Key key,
    this.refreshEmailCallBack,
    this.fullName,
    this.updatedEmail,
    this.updatedData,
  }) : super(key: key);
  @override
  _ChangeEmailViewState createState() => _ChangeEmailViewState();
}

class _ChangeEmailViewState extends State<ChangeEmailView> {
  final _passwordController = TextEditingController();
  final _auth = Auth();
  final _firebaseAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  bool _isUpdating = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BackButton(
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    SvgPicture.asset(
                      'assets/changeEmail.svg',
                      height: 100.0,
                      // height: height * 0.2,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text("Email Updated!",
                        style: Theme.of(context).textTheme.headline1),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info,
                          size: 20.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Enter Password for verification!",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                      textEditingController: _passwordController,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: "Enter Password",
                      icon: Icons.lock,
                      isPassword: true,
                      validatorFtn: (value) {
                        if (value.isEmpty) {
                          return "Password cannot be emtpy!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    CustomButton(
                      btnWidth: width * 0.7,
                      btnHeight: 40.0,
                      btnOnPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _isUpdating = true;
                          });

                          // updating the email
                          var value = await _auth
                              .updateEmail(
                            _firebaseAuth.currentUser,
                            widget.updatedEmail,
                            _passwordController.text.trim(),
                          )
                              .whenComplete(() {
                            setState(() {
                              _isUpdating = false;
                            });
                          });

                          // updating the user data
                          await _auth.updateData(
                            _firebaseAuth.currentUser,
                            widget.fullName,
                            widget.updatedData,
                          );

                          if (value is String) {
                            var snackBar = SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: kMediumGreenColor,
                              content: Row(
                                children: [
                                  Icon(Icons.info, color: Colors.red[700]),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            var snackBar = SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: kSecondaryBlueColor,
                              content: Row(
                                children: [
                                  Icon(Icons.check, color: Colors.white),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    "Email updated. Verification link has been sent!",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            int count = 0;
                            Navigator.popUntil(
                                context, (route) => count++ >= 2);
                            // Navigator.pop(context);
                            widget.refreshEmailCallBack(true);
                          }
                        }
                      },
                      btnColor: Provider.of<ThemeProvider>(context).darkTheme
                          ? kMediumBlueColor
                          : kPrimaryBlueColor,
                      btnText: _isUpdating
                          ? kLoader
                          : Text(
                              "Confirm",
                              style: kBtnTextStyle,
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
