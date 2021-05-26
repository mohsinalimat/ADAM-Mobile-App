import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(
                      color: kPrimaryBlueColor,
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
                  Text(
                    "Change Password!",
                    style: TextStyle(
                        color: kPrimaryBlueColor,
                        fontWeight: FontWeight.bold,
                        // fontSize: height * 0.04,
                        fontSize: 28.0),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Make sure to login after changing password.",
                    style: TextStyle(
                      color: kPrimaryBlueColor,
                    ),
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
                    validatorFtn: (value) {
                      bool passValid = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                          .hasMatch(value);
                      if (value.isEmpty) {
                        return "Password cannot be empty!";
                      } else if (!passValid) {
                        return "Uppercase, lowercase, Number and Special character required!";
                      } else if (value.length < 6) {
                        return "Password must be greater than 6 characters!";
                      }
                      return null;
                    },
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
                      } else if (value != _newPasswordController.text.trim()) {
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
                              title: Text("Security Check!"),
                              content: Text(value),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Back"),
                                )
                              ],
                            ),
                          );
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
                            Navigator.popUntil(
                                context, (route) => route.settings.name == "/");
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            clearController();
                          });
                        }
                      }
                    },
                    btnColor: kPrimaryBlueColor,
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
    );
  }
}
