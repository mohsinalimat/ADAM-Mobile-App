import 'package:adam/app_routes.dart';
import 'package:adam/auth/user_auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/validators/validators.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/custom_text_field.dart';
import 'package:adam/widgets/pass_requirement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final UserAuth _userAuth = UserAuth();

  String _passCheck = "";
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // final _oldPassController = TextEditingController();
  // final _auth = Auth();
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
                          "You will be logged out after changing password.",
                        ),
                        SizedBox(height: height * 0.05),
                        CustomTextField(
                          textEditingController: _newPasswordController,
                          textInputAction: TextInputAction.done,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Theme(
                            data: ThemeData().copyWith(
                              dividerColor: Colors.transparent,
                              unselectedWidgetColor:
                                  Provider.of<ThemeProvider>(context).darkTheme
                                      ? Colors.white
                                      : kPrimaryBlueColor,
                            ),
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
                          btnWidth: width * 0.9,
                          btnHeight: 45.0,
                          btnOnPressed: _changePassword,
                          btnColor:
                              Provider.of<ThemeProvider>(context).darkTheme
                                  ? kMediumBlueColor
                                  : kPrimaryBlueColor,
                          btnText: _updatingPass
                              ? kLoaderWhite
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

  void _changePassword() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _updatingPass = true;
      });

      int code = await _userAuth
          .changePassword(
        _newPasswordController.text.trim(),
        _confirmPasswordController.text.trim(),
      )
          .whenComplete(() {
        setState(() {
          _updatingPass = false;
        });
      });

      if (code == 200) {
        if (mounted) {
          customSnackBar(
            context,
            kSecondaryBlueColor,
            Row(
              children: [
                const Icon(Icons.lock_rounded, color: Colors.white),
                const SizedBox(width: 8),
                const Text('Password updated successfully! Re-login please.')
              ],
            ),
          );
          Navigator.popUntil(
              context, (route) => route.settings?.name == AppRoutes.login);
          await _userAuth.logout(context);
        }
      }
    }
  }
}
