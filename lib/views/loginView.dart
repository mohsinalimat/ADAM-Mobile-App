import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/views/mainView.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _auth = Auth();

  final emailTextController = TextEditingController();
  final forgorEmailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    forgorEmailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.07,
                  ),
                  SvgPicture.asset(
                    "assets/logo/logoColor.svg",
                    height: height * 0.1,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    "Automated Digital Assitant in Marketing",
                    style: TextStyle(
                      color: kPrimaryBlueColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  CustomTextField(
                    hintText: "Enter Email",
                    icon: Icons.email,
                    node: node,
                    onChangeFtn: (value) => print(value),
                    onEditComplete: () => node.nextFocus(),
                    textEditingController: emailTextController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
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
                    height: height * 0.03,
                  ),
                  CustomTextField(
                    hintText: "Enter Password",
                    icon: Icons.lock,
                    isPassword: true,
                    node: node,
                    onChangeFtn: (value) => print(value),
                    onFieldSubmit: (value) => node.unfocus(),
                    textEditingController: passwordTextController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    validatorFtn: (value) {
                      if (value.isEmpty) {
                        return "Password cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  CustomButton(
                    btnWidth: width * 0.8,
                    btnHeight: height * 0.055,
                    node: node,
                    btnColor: kPrimaryBlueColor,
                    btnText: "Login",
                    btnOnPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var value = await _auth.login(
                            emailTextController.text.trim(),
                            passwordTextController.text.trim());
                        if (value is String) {
                          print("Error: " + value);
                          var snackBar = SnackBar(
                            content: Text(
                              value,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red[900],
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => MainView()));
                          emailTextController.clear();
                          passwordTextController.clear();
                          node.unfocus();
                        }
                      } else {
                        print("Text Fields Emapty!");
                      }
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          color: kPrimaryBlueColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.04),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Reset link will be sent to your email.",
                                      style: TextStyle(
                                        color: kPrimaryBlueColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.035,
                                  ),
                                  CustomTextField(
                                    textEditingController:
                                        forgorEmailTextController,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.emailAddress,
                                    node: node,
                                    hintText: "Enter Email",
                                    icon: Icons.email,
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  CustomButton(
                                    btnWidth: width * 0.5,
                                    btnHeight: height * 0.055,
                                    btnOnPressed: () async {
                                      var value = await _auth.forgotPassword(
                                          forgorEmailTextController.text
                                              .trim());
                                      if (value is String) {
                                        print("VALUEEE: " + value.toString());
                                        var snackBar = SnackBar(
                                            backgroundColor: Colors.red[900],
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              value,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ));
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        forgorEmailTextController.clear();
                                      } else {
                                        forgorEmailTextController.clear();
                                        var snackBar = SnackBar(
                                            backgroundColor:
                                                kSecondaryBlueColor,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                                "Instructions has been sent to your email address."));
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    btnColor: kPrimaryBlueColor,
                                    btnText: "Get Link",
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text("Forgot Password?")),
                  Text(
                    "_________________________________________\n",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  CustomButton(
                    btnWidth: width * 0.6,
                    btnHeight: height * 0.055,
                    btnOnPressed: () => Navigator.pushNamed(context, "/signUp"),
                    btnColor: kLightGreenColor,
                    btnText: "Create New Account",
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
