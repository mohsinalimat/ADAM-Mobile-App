import 'package:adam/auth/user_auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final forgorEmailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final node = FocusNode();
  final _userAuth = UserAuth();

  bool _isLoading = false;

  @override
  void dispose() {
    forgorEmailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return AbsorbPointer(
      absorbing: _isLoading,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                        'assets/forgot.svg',
                        height: 100,
                        // height: height * 0.2,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text("Reset link will be sent to your email."),
                      SizedBox(height: height * 0.1),
                      CustomTextField(
                        textEditingController: forgorEmailTextController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        node: node,
                        hintText: "Enter Email",
                        icon: Icons.email,
                        validatorFtn: (value) {
                          bool emailValid = RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value);

                          if (!emailValid) {
                            return "Invalid Email address!";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomButton(
                        btnWidth: width * 0.6,
                        // btnHeight: height * 0.055,
                        btnHeight: 40.0,
                        btnOnPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });

                            var result = await _userAuth
                                .forgotPassword(
                                    forgorEmailTextController.text.trim())
                                .whenComplete(() {
                              setState(() {
                                _isLoading = false;
                              });
                            });
                            print(result);
                            if (result is String) {
                              forgorEmailTextController.clear();

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Reset Link!"),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                          "Reset password by clicking the button below!"),
                                      const SizedBox(
                                        height: 25.0,
                                      ),
                                      CustomButton(
                                        btnWidth: 250.0,
                                        btnHeight: 45.0,
                                        btnOnPressed: () async {
                                          await launch(result.toString());

                                          Navigator.popUntil(
                                              context,
                                              (route) =>
                                                  route.settings?.name == "/");
                                        },
                                        btnColor: kLightBlueColor,
                                        btnText: Text(
                                          "Reset Password",
                                          style: kBtnTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Back"))
                                  ],
                                ),
                              );
                              // var snackBar = SnackBar(
                              //     content: Row(
                              //   children: [
                              //     Icon(Icons.link, color: Colors.white),
                              //     const SizedBox(width: 8.0),
                              //     Expanded(
                              //       child: Text(
                              //         "Reset link has been sent to your Email",
                              //       ),
                              //     ),
                              //   ],
                              // ));
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(snackBar);
                              // Navigator.pop(context);
                            } else if (result == 204) {
                              var snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " Account does not exists!",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              var snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " Unknown error! Try Again!",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            // var value = await _auth
                            //     .forgotPassword(
                            //         forgorEmailTextController.text.trim())
                            //     .whenComplete(() {
                            //   setState(() {
                            //     _isLoading = false;
                            //   });
                            // });
                            // if (value is String) {
                            //   print("Valueeee: " + value.toString());
                            // var snackBar = SnackBar(
                            //     backgroundColor: Colors.red,
                            //     content: Row(
                            //       children: [
                            //         Icon(
                            //           Icons.info,
                            //           color: Colors.white,
                            //         ),
                            //         Text(
                            //           " $value",
                            //           style: TextStyle(
                            //             color: Colors.white,
                            //           ),
                            //         ),
                            //       ],
                            //     ));
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);
                            // } else {
                            // forgorEmailTextController.clear();
                            // var snackBar = SnackBar(
                            //     content: Row(
                            //   children: [
                            //     Icon(Icons.link, color: Colors.white),
                            //     const SizedBox(width: 8.0),
                            //     Expanded(
                            //       child: Text(
                            //         "Reset link has been sent to your Email",
                            //       ),
                            //     ),
                            //   ],
                            // ));
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);

                            // Navigator.pop(context);
                            // }
                          }
                        },
                        btnColor: _themeProvider.darkTheme
                            ? kMediumBlueColor
                            : kPrimaryBlueColor,
                        btnText: _isLoading
                            ? kLoaderWhite
                            : Text(
                                "Send",
                                style: kBtnTextStyle,
                              ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Remember Password?",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Login"),
                          )
                        ],
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
