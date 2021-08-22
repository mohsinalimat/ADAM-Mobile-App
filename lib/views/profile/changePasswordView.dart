import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/validators/validators.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:adam/widgets/passCheckRequirementWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  String _passCheck = "";
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _oldPassController = TextEditingController();
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
        child: ScaffoldMessenger(
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
                          height: height * 0.035,
                        ),
                        SvgPicture.asset(
                          'assets/forgot.svg',
                          height: 100,
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
                        SizedBox(height: height * 0.05),
                        // TODO: Shift this to mongoDB
                        // CustomTextField(
                        //   textEditingController: _oldPassController,
                        //   textInputAction: TextInputAction.next,
                        //   textInputType: TextInputType.text,
                        //   hintText: "Old Password",
                        //   node: node,
                        //   icon: Icons.lock_open,
                        //   isPassword: true,
                        //   onFieldSubmit: (value) => node.nextFocus(),
                        // ),
                        // SizedBox(height: 10),
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
                          onChangeFtn: (value) {
                            setState(() {
                              _passCheck = value;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: ListTileTheme(
                            dense: true,
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.all(0.0),
                              title: Row(
                                children: [
                                  Icon(Icons.check_circle_rounded,
                                      color: Validators.passwordValidator(
                                                  _newPasswordController.text
                                                      .trim()) ==
                                              null
                                          ? Colors.green
                                          : _newPasswordController.text
                                                      .trim() ==
                                                  ""
                                              ? Colors.grey
                                              : Colors.red),
                                  Text(
                                    " Requirements",
                                    style: TextStyle(
                                        color: Validators.passwordValidator(
                                                    _newPasswordController.text
                                                        .trim()) ==
                                                null
                                            ? Colors.green
                                            : _newPasswordController.text
                                                        .trim() ==
                                                    ""
                                                ? Colors.grey
                                                : Colors.red),
                                  ),
                                ],
                              ),
                              children: [
                                PassCheckRequirements(
                                  passCheck:
                                      _passCheck.contains(RegExp(r'[A-Z]')),
                                  requirement: "1 Uppercase [A-Z]",
                                ),
                                PassCheckRequirements(
                                  passCheck:
                                      _passCheck.contains(RegExp(r'[a-z]')),
                                  requirement: "1 lower [a-z]",
                                ),
                                PassCheckRequirements(
                                  passCheck:
                                      _passCheck.contains(RegExp(r'[0-9]')),
                                  requirement: "1 number [0-9]",
                                ),
                                PassCheckRequirements(
                                  passCheck: _passCheck.contains(
                                      RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                                  requirement:
                                      "1 special character [@, \$, # etc.]",
                                ),
                                PassCheckRequirements(
                                  passCheck: _passCheck.length >= 6,
                                  requirement: "6 characters minimum",
                                ),
                              ].map((e) => e).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
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
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                    .darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                    content: Text(value),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          var snackBar = SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Row(
                                              children: [
                                                Icon(Icons.check,
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
                                          _auth.signOut(context);
                                        },
                                        child: Text("Logout"),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Back"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                var snackBar = SnackBar(
                                  backgroundColor: Colors.green,
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

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                clearController();
                                _auth.signOut(context);
                              }
                            }
                          },
                          btnColor:
                              Provider.of<ThemeProvider>(context).darkTheme
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
      ),
    );
  }
}
