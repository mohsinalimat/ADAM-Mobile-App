import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/validators/validators.dart';
import 'package:adam/views/settings/settingsView.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _auth = Auth();
  final _formKey = GlobalKey<FormState>();
  bool _updatingPass = false;

  clearController() {
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final node = FocusScope.of(context);

    return AbsorbPointer(
      absorbing: _updatingPass,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                        'assets/forgot.svg',
                        height: 100.0,
                        // height: height * 0.2,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text("Change Password!",
                          style: Theme.of(context).textTheme.headline1),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "Make sure to login after changing password.",
                      ),
                      SizedBox(height: height * 0.1),
                      CustomTextField(
                        textEditingController: _newPasswordController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        hintText: "New Password",
                        node: node,
                        icon: Icons.lock_open,
                        isPassword: true,
                        onFieldSubmit: (value) => node.nextFocus(),
                        validatorFtn: Validators.passwordValidator,
                      ),
                      SizedBox(height: 20.0),
                      CustomTextField(
                        node: node,
                        isPassword: true,
                        textEditingController: _confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        hintText: "Confirm New Password",
                        icon: Icons.lock,
                        validatorFtn: (value) {
                          if (value.isEmpty) {
                            return "Password cannot be empty!";
                          } else if (value !=
                              _newPasswordController.text.trim()) {
                            return "Password Mismatch!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.03),
                      CustomButton(
                        btnWidth: width * 0.8,
                        btnHeight: 40.0,
                        btnOnPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _updatingPass = true;
                            });
                            print("VALID PASSWORD");
                            var value = await _auth
                                .changePassword(
                              _confirmPasswordController.text.trim(),
                            )
                                .whenComplete(() {
                              setState(() {
                                _updatingPass = false;
                              });
                            });
                            if (value is String) {
                              print(value);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "Security Check!",
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .fontSize,
                                      color: Provider.of<ThemeProvider>(context)
                                              .darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  content: Text(value),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        var snackBar = SnackBar(
                                          backgroundColor: kMediumGreenColor,
                                          behavior: SnackBarBehavior.floating,
                                          content: Row(
                                            children: [
                                              Icon(Icons.info,
                                                  color: Colors.white),
                                              SizedBox(width: 8.0),
                                              Text(
                                                "Sign Out Successful!",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        FirebaseAuth.instance.signOut();
                                        preferences.remove("userId");
                                        Navigator.popUntil(
                                            context,
                                            (route) =>
                                                route.settings.name == "/");
                                      },
                                      child: Text("Logout"),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              var snackBar = SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: kMediumGreenColor,
                                content: Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.white),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      "Password updated! Please login.",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              await FirebaseAuth.instance
                                  .signOut()
                                  .whenComplete(() {
                                Navigator.popUntil(context,
                                    (route) => route.settings.name == "/");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                clearController();
                              });
                            }
                          }
                        },
                        btnColor: Provider.of<ThemeProvider>(context).darkTheme
                            ? kMediumBlueColor
                            : kPrimaryBlueColor,
                        btnText: _updatingPass
                            ? kLoader
                            : Text(
                                "Change Password",
                                style: kBtnTextStyle,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
