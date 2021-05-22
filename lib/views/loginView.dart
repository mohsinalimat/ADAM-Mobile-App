import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/views/mainView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatelessWidget {
  final _auth = Auth();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              SvgPicture.asset(
                "assets/logo/logoColor.svg",
                height: height * 0.1,
              ),
              Expanded(child: Container()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.8,
                    child: TextFormField(
                      controller: emailTextController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        print(value);
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        contentPadding: const EdgeInsets.all(5.0),
                        hintText: "Enter Email",
                        hintStyle: kHintTextStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        bool emailValid = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value);

                        if (!emailValid) {
                          return "Invalid Email address!";
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: TextFormField(
                      controller: passwordTextController,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        print(value);
                      },
                      onFieldSubmitted: (value) {
                        node.unfocus();
                      },
                      validator: (value) {
                        // bool passValid = RegExp(
                        //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                        //     .hasMatch(value);
                        // if (!passValid) {
                        //   return "Uppercase, lowercase, number and special character is required!";
                        // } else if (value.length < 6) {
                        //   return "Password must be greater than 6 characters!";
                        // }
                        if (value.isEmpty) {
                          return "Password cannot be empty!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        contentPadding: const EdgeInsets.all(5.0),
                        hintText: "Enter Password",
                        hintStyle: kHintTextStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text("Forgot Password?")),
                ],
              ),
              SizedBox(
                height: height * 0.04,
              ),
              SizedBox(
                width: width * 0.5,
                height: height * 0.055,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: kLightGreenColor,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var value = await _auth.login(
                          emailTextController.text.trim(),
                          passwordTextController.text.trim());
                      if (value is String) {
                        print("Error: " + value);
                        var snackBar = SnackBar(
                          content: Text(
                            "ERROR: $value",
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
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("New Here?"),
                  TextButton(onPressed: () {}, child: Text("Create Account")),
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      )),
    );
  }
}
