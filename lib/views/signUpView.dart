import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/views/setupProfilePic.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dobController = TextEditingController();

  final format = DateFormat("dd-MM-yyyy");

  final _auth = Auth();

  String _gender = "Male";
  String _country = "Pakistan";
  String _city = "Islamabad";

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  _clearController() {
    fullNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    dobController.clear();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AbsorbPointer(
        absorbing: _isLoading,
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
                    SvgPicture.asset(
                      "assets/logo/logoColor.svg",
                      // height: height * 0.07,
                      height: 40.0,
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
                      height: height * 0.04,
                    ),
                    SizedBox(
                      width: width * 0.9,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sign Up",
                              style: kHeadingStyle,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "It's quick and easy",
                              style: TextStyle(
                                  color: kPrimaryBlueColor, fontSize: 14.0
                                  // fontSize: height * 0.017,
                                  ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          CustomTextField(
                            textEditingController: fullNameController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            node: node,
                            hintText: "Full Name",
                            icon: Icons.person,
                            onChangeFtn: (value) => print(value),
                            validatorFtn: (value) {
                              if (value.isEmpty) {
                                return "Name cannot be empty!";
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextField(
                            textEditingController: emailController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            node: node,
                            hintText: "Email Address",
                            icon: Icons.email,
                            validatorFtn: (value) {
                              bool emailValid = RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value);

                              if (value.isEmpty) {
                                return "Email cannot be empty!";
                              } else if (!emailValid) {
                                return "Invalid Email address!";
                              }

                              return null;
                            },
                            onChangeFtn: (value) => print(value),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextField(
                            textEditingController: phoneNumberController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.phone,
                            node: node,
                            hintText: "Phone Number",
                            icon: Icons.phone,
                            onChangeFtn: (value) => print(value),
                            validatorFtn: (value) {
                              bool validPhone = RegExp(
                                      r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$')
                                  .hasMatch(value);
                              if (value.isEmpty) {
                                return "Phone number cannot be empty!";
                              } else if (!validPhone) {
                                return "Invalid Phone Number!";
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextField(
                            textEditingController: passwordController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            node: node,
                            isPassword: true,
                            hintText: "Password",
                            icon: Icons.lock_open,
                            validatorFtn: (value) {
                              bool passValid = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                                  .hasMatch(value);
                              if (value.isEmpty) {
                                return "Password cannot be empty!";
                              } else if (!passValid) {
                                return "Uppercase, lowercase, number and special character is required!";
                              } else if (value.length < 6) {
                                return "Password must be greater than 6 characters!";
                              }
                              return null;
                            },
                            onChangeFtn: (value) => print(value),
                            onFieldSubmit: (value) => node.nextFocus(),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextField(
                            textEditingController: confirmPasswordController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            node: node,
                            isPassword: true,
                            hintText: "Confirm Password",
                            icon: Icons.lock,
                            validatorFtn: (value) {
                              if (value.isEmpty) {
                                return "Password cannot be empty!";
                              } else if (value !=
                                  passwordController.text.trim()) {
                                return "Password Mismatch!";
                              }
                              return null;
                            },
                            onChangeFtn: (value) => print(value),
                            onFieldSubmit: (value) => node.nextFocus(),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          DateTimeField(
                            controller: dobController,
                            validator: (value) {
                              if (value == null) {
                                return "Date of birth is not selected!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: kPrimaryBlueColor,
                              ),
                              contentPadding: const EdgeInsets.all(5.0),
                              hintText: "Date of Birth",
                              hintStyle: kHintTextStyle,
                            ),
                            format: format,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2100),
                              );
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  // fontSize: height * 0.017,
                                  fontSize: 14.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Male"),
                                  Radio(
                                    value: "Male",
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value;
                                      });
                                      print(_gender);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Female"),
                                  Radio(
                                    value: "Female",
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value;
                                      });
                                      print(_gender);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Custom"),
                                  Radio(
                                    value: "Custom",
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value;
                                      });
                                      print(_gender);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Address\n",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  // fontSize: height * 0.017,
                                  fontSize: 14.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: width * 0.42,
                                height: 40.0,
                                // height: height * 0.055,
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  elevation: 4.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: _country,
                                        items: ["Pakistan", "USA", "Canada"]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          _country = value;
                                          print(_country);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.42,
                                // height: height * 0.055,
                                height: 40.0,
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  elevation: 4.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: _city,
                                        items:
                                            ["Islamabad", "Lahore", "Karachi"]
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    child: Text(e),
                                                    value: e,
                                                  ),
                                                )
                                                .toList(),
                                        onChanged: (value) {
                                          _city = value;
                                          print(_city);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          CustomButton(
                            btnWidth: width * 0.9,
                            // btnHeight: height * 0.055,
                            btnHeight: 40.0,
                            btnOnPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                var result = await _auth
                                    .signUp(
                                  fullNameController.text.trim(),
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  phoneNumberController.text.trim(),
                                  dobController.text,
                                  _gender,
                                  _country,
                                  _city,
                                )
                                    .whenComplete(() {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                                if (result is String) {
                                  var snackBar = SnackBar(
                                    content: Text(result,
                                        style: TextStyle(color: Colors.white)),
                                    backgroundColor: Colors.red[900],
                                    behavior: SnackBarBehavior.floating,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  var snackBar = SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.done_rounded,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                              "Account Created Successfully. Check your email!",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: kMediumGreenColor,
                                    behavior: SnackBarBehavior.floating,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  _clearController();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SetupProfilePic(),
                                    ),
                                  );
                                }
                              }
                            },
                            btnColor: kMediumGreenColor,
                            btnText: _isLoading
                                ? SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text("Sign Up", style: kBtnTextStyle),
                          ),
                          Text(
                              "\n\nBy clicking Sign Up, you agree to Terms, data policy and cookies policy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kPrimaryBlueColor,
                                  // fontSize: height * 0.015,
                                  fontSize: 12.0)),
                          SizedBox(
                            height: height * 0.05,
                          ),
                        ],
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
