import 'package:adam/auth/userAuth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/validators/validators.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:adam/widgets/passCheckRequirementWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as https;

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _passCheck = '';
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  final format = DateFormat("dd-MM-yyyy");

  final _userAuth = UserAuth();

  String _gender = "Male";
  String _country = "Pakistan";
  String _city = "Islamabad";
  List<dynamic> _citiesName = [];

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  // verification
  bool _isEmailVerified = false;
  bool _isEmailTyping = false;
  bool _isGeneratingEmailCode = false;
  bool _isSubmittingEmailCode = false;

  bool _isPhoneVerified = false;
  bool _isPhoneTyping = false;
  bool _isGeneratingPhoneCode = false;
  bool _isSubmittingPhoneCode = false;

  _clearController() {
    fullNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    dobController.clear();
  }

  Future<String> loadCityData() async {
    var jsonTxt = await rootBundle.loadString('pk.json');
    setState(() {
      _citiesName = json.decode(jsonTxt);
    });

    _citiesName.sort((a, b) => a.toString().compareTo(b.toString()));

    return 'success';
  }

  @override
  void initState() {
    phoneNumberController.text = "+92";
    loadCityData();
    super.initState();
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
    final _themeProvider = Provider.of<ThemeProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AbsorbPointer(
        absorbing:
            _isLoading || _isGeneratingEmailCode || _isGeneratingPhoneCode,
        child: Scaffold(
          body: SafeArea(
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
                    Hero(
                      tag: 'logo',
                      child: SvgPicture.asset("assets/logo/logoColor.svg",
                          height: 35),
                    ),
                    SizedBox(height: height * 0.02),
                    Hero(
                      tag: 'logoText',
                      child: Material(
                        child: const Text(
                          "Automated Digital Assitant in Marketing",
                          style: TextStyle(letterSpacing: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    SizedBox(
                      width: width * 0.9,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sign Up",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "It's quick and easy",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          CustomTextField(
                            textEditingController: fullNameController,
                            textInputAction: TextInputAction.done,
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
                          SizedBox(height: height * 0.02),
                          CustomTextField(
                            textEditingController: emailController,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            node: node,
                            hintText: "Email Address",
                            icon: Icons.email,
                            validatorFtn: Validators.emailValidator,
                            onChangeFtn: (value) {
                              print(value);

                              if (value.length == 0) {
                                setState(() {
                                  _isEmailTyping = false;
                                });
                              } else {
                                setState(() {
                                  _isEmailTyping = true;
                                });
                              }
                            },
                          ),
                          _isEmailTyping
                              ? SizedBox(height: height * 0.02)
                              : SizedBox(),
                          _isEmailTyping
                              ? CustomButton(
                                  btnWidth: MediaQuery.of(context).size.width,
                                  btnHeight: 42.0,
                                  btnOnPressed: _generateEmailCode,
                                  // btnOnPressed: _showEmailCodeBox,
                                  btnColor: kPrimaryBlueColor,
                                  btnText: _isGeneratingEmailCode
                                      ? kLoaderWhite
                                      : const Text(
                                          'Verify Email',
                                          style: kBtnTextStyle,
                                        ),
                                )
                              : SizedBox(),
                          SizedBox(height: height * 0.02),
                          CustomTextField(
                            textEditingController: phoneNumberController,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.phone,
                            node: node,
                            hintText: "Phone Number",
                            icon: Icons.phone,
                            onChangeFtn: (value) {
                              print(value);

                              if (value.length == 0) {
                                setState(() {
                                  _isPhoneTyping = false;
                                });
                              } else {
                                setState(() {
                                  _isPhoneTyping = true;
                                });
                              }
                            },
                            validatorFtn: Validators.phoneNumberValidator,
                          ),
                          _isPhoneTyping
                              ? SizedBox(height: height * 0.02)
                              : SizedBox(),
                          _isPhoneTyping
                              ? CustomButton(
                                  btnWidth: MediaQuery.of(context).size.width,
                                  btnHeight: 42.0,
                                  btnOnPressed: _generatePhoneCode,
                                  btnColor: kPrimaryBlueColor,
                                  btnText: _isGeneratingPhoneCode
                                      ? kLoaderWhite
                                      : const Text(
                                          'Verify Phone',
                                          style: kBtnTextStyle,
                                        ),
                                )
                              : SizedBox(),
                          SizedBox(height: height * 0.02),
                          CustomTextField(
                            textEditingController: passwordController,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            node: node,
                            isPassword: true,
                            hintText: "Password",
                            icon: Icons.lock_open,
                            validatorFtn: Validators.passwordValidator,
                            onChangeFtn: (value) {
                              setState(() {
                                _passCheck = value;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Theme(
                              data: ThemeData().copyWith(
                                dividerColor: Colors.transparent,
                                unselectedWidgetColor:
                                    Provider.of<ThemeProvider>(context)
                                            .darkTheme
                                        ? Colors.white
                                        : kPrimaryBlueColor,
                              ),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.all(0.0),
                                title: Row(
                                  children: [
                                    Icon(Icons.check_circle_rounded,
                                        color: Validators.passwordValidator(
                                                    passwordController.text
                                                        .trim()) ==
                                                null
                                            ? Colors.green
                                            : passwordController.text.trim() ==
                                                    ""
                                                ? Colors.grey
                                                : Colors.red),
                                    Text(
                                      " Requirements",
                                      style: TextStyle(
                                          color: Validators.passwordValidator(
                                                      passwordController.text
                                                          .trim()) ==
                                                  null
                                              ? Colors.green
                                              : passwordController.text
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
                          SizedBox(height: height * 0.01),
                          CustomTextField(
                            textEditingController: confirmPasswordController,
                            textInputAction: TextInputAction.done,
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
                            validator: Validators.dobValidator,
                            decoration: InputDecoration(
                              fillColor: _themeProvider.darkTheme
                                  ? Colors.black12
                                  : Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: _themeProvider.darkTheme
                                    ? Colors.white
                                    : kPrimaryBlueColor,
                              ),
                              contentPadding: const EdgeInsets.all(5.0),
                              hintText: "Date of Birth",
                              hintStyle: Theme.of(context).textTheme.caption,
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
                                  Text("Others"),
                                  Radio(
                                    value: "Others",
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
                              Expanded(
                                child: SizedBox(
                                  width: 250,
                                  height: 40.0,
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    elevation: 4.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: _country,
                                          items: [
                                            DropdownMenuItem(
                                              value: "Pakistan",
                                              child: Text("Pakistan"),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            _country = value;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: SizedBox(
                                  width: 250,
                                  height: 40.0,
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    elevation: 4.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: _city,
                                          items: [
                                            for (int i = 0;
                                                i < _citiesName.length;
                                                i++)
                                              DropdownMenuItem(
                                                value: _citiesName[i]['city'],
                                                child: Text(
                                                  _citiesName[i]['city'],
                                                ),
                                              ),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _city = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.03),
                          CustomButton(
                            btnWidth: width * 0.9,
                            // btnHeight: height * 0.055,
                            btnHeight: 40.0,
                            btnOnPressed: _signUp,
                            btnColor: kLightGreenColor,
                            btnText: _isLoading
                                ? kLoaderWhite
                                : const Text(
                                    "Sign Up",
                                    style: kBtnTextStyle,
                                  ),
                          ),
                          const Text(
                            "\n\nBy clicking Sign Up, you agree to Terms, data policy and cookies policy",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
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

  /// `Node signup`
  void _signUp() async {
    print(_isEmailVerified);

    if (_formKey.currentState.validate()) {
      if (!_isEmailVerified || !_isPhoneVerified) {
        _errorSignup('Email/Phone Number NOT verified!');
      } else {
        setState(() {
          _isLoading = true;
        });

        int result = await _userAuth
            .signUp(
          fullName: fullNameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneNumberController.text.trim(),
          password: passwordController.text.trim(),
          dob: dobController.text.trim(),
          gender: _gender,
          city: _city,
          country: _country,
        )
            .whenComplete(() {
          setState(() {
            _isLoading = false;
          });
        });

        if (result == 200) {
          _signUpSuccessful();
        } else if (result == 204) {
          _errorSignup("Account already exists!");
        } else {
          _errorSignup("Undefined error!");
        }
      }
    }
  }

  void _signUpSuccessful() {
    var snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.done_rounded,
            color: Colors.white,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: const Text("Account created successfully!",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: kSecondaryBlueColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _clearController();
    Navigator.pop(context);
  }

  void _errorSignup(String value) {
    print("Error: " + value);
    customSnackBar(
      context,
      Colors.red,
      Row(
        children: [
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  // email verification
  void _generateEmailCode() async {
    setState(() {
      _isGeneratingEmailCode = true;
    });

    String _url = "https://adam-web-api.herokuapp.com/user/generate-email-code";

    https.Response response = await https.post(
      Uri.parse(_url),
      body: {
        "cust_email": emailController.text.trim(),
      },
    ).whenComplete(() {
      setState(() {
        _isGeneratingEmailCode = false;
      });
    });

    if (response.statusCode == 200) {
      _showCodeAlertBox(true);
    } else if (response.statusCode == 204) {
      print('already taken email!');
      _errorSignup("Email has been taken already, please login!");
    } else {
      print('some other error!');
      _errorSignup("Unknown error occured!");
    }
  }

  // phone verification
  void _generatePhoneCode() async {
    setState(() {
      _isGeneratingPhoneCode = true;
    });

    String _url = "https://adam-web-api.herokuapp.com/user/generate-sms-code";

    https.Response response = await https.post(
      Uri.parse(_url),
      body: {
        "cust_phone": phoneNumberController.text.trim(),
      },
    ).whenComplete(() {
      setState(() {
        _isGeneratingPhoneCode = false;
      });
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      _showCodeAlertBox(false);
    } else {
      print('some other error!');
      _errorSignup("Unknown error occured!");
    }
  }

  // code box
  void _showCodeAlertBox(bool isEmail) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        TextEditingController codeController = TextEditingController();

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(
              isEmail ? "Email Verification" : "Phone Number Verification",
              style: Theme.of(context).textTheme.headline2,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  child: Text(
                    isEmail
                        ? "Enter 4-Digit code sent at your email. \n\n*Check Spam/Promotion mails!"
                        : "Enter 4-Digit code sent at your phone number.",
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                PinCodeTextField(
                  controller: codeController,
                  keyboardType: TextInputType.number,
                  textStyle: Provider.of<ThemeProvider>(context).darkTheme
                      ? TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        )
                      : TextStyle(fontSize: 14.0),
                  appContext: context,
                  length: 4,
                  onChanged: (value) {},
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    inactiveColor: kPrimaryBlueColor,
                    activeColor: kMediumGreenColor,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                CustomButton(
                  btnWidth: MediaQuery.of(context).size.width,
                  btnHeight: 42.0,
                  btnOnPressed: isEmail
                      ? () async {
                          setState(() {
                            _isSubmittingEmailCode = true;
                          });

                          String _url =
                              "https://adam-web-api.herokuapp.com/user/verify-email-code";

                          https.Response response = await https.post(
                            Uri.parse(_url),
                            body: {
                              "cust_email": emailController.text.trim(),
                              "code": codeController.text.trim(),
                            },
                          ).whenComplete(() {
                            setState(() {
                              _isSubmittingEmailCode = false;
                            });
                          });

                          if (response.statusCode == 200) {
                            setState(() {
                              _isEmailVerified = true;
                              _isEmailTyping = false;
                            });
                            customSnackBar(
                              context,
                              kSecondaryBlueColor,
                              Row(
                                children: [
                                  Icon(
                                    Icons.mark_chat_read,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    "Email verified successfully!",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                            Navigator.pop(context);
                          } else if (response.statusCode == 204) {
                            print('already taken email!');
                            _errorSignup("Invalid code entered!");
                          } else {
                            print('some other error!');
                            _errorSignup("Unknown error occured!");
                          }
                        }
                      : () async {
                          setState(() {
                            _isSubmittingPhoneCode = true;
                          });

                          String _url =
                              "https://adam-web-api.herokuapp.com/user/verify-sms-code";

                          https.Response response = await https.post(
                            Uri.parse(_url),
                            body: {
                              "cust_phone": phoneNumberController.text.trim(),
                              "code": codeController.text.trim(),
                            },
                          ).whenComplete(() {
                            setState(() {
                              _isSubmittingPhoneCode = false;
                            });
                          });

                          if (response.statusCode == 200) {
                            setState(() {
                              _isPhoneVerified = false;
                              _isPhoneTyping = false;
                            });
                            customSnackBar(
                              context,
                              kSecondaryBlueColor,
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    "Phone number verified successfully!",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                            Navigator.pop(context);
                          } else if (response.statusCode == 204) {
                            _errorSignup("Invalid code entered!");
                          } else {
                            print('some other error!');
                            _errorSignup("Unknown error occured!");
                          }
                        },
                  btnColor: kMediumGreenColor,
                  btnText: _isSubmittingEmailCode || _isSubmittingPhoneCode
                      ? kLoaderWhite
                      : const Text(
                          "Submit",
                          style: kBtnTextStyle,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
