import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/validators/validators.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:adam/widgets/passCheckRequirementWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _passCheck = '';
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
  // List<String> _countryNames = [];
  List<dynamic> _citiesName = [];

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

  // void _initalizingCountryNames() {
  //   CountryAPI().getCountryNames().then((value) {
  //     for (int i = 0; i < value.names.length; i++) {
  //       _countryNames.add(value.names[i].name);
  //     }
  //   }).whenComplete(() {
  //     setState(() {
  //       _countryLoaded = false;
  //     });
  //   });
  // }

  // void _initalizingCitiesNames() {
  //   CityAPI().getCityNames().then((value) {
  //     for (int i = 0; i < value.names.length; i++) {
  //       _citiesName.add(value.names[i].name);
  //     }
  //   }).whenComplete(() {
  //     _cityLoaded = false;
  //   });
  // }

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
    // _initalizingCountryNames();
    loadCityData();
    // _initalizingCitiesNames();
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
        absorbing: _isLoading,
        child: ScaffoldMessenger(
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
                          // color: kPrimaryBlueColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/logo/logoColor.svg",
                        // height: height * 0.07,
                        height: 40,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Automated Digital Assitant in Marketing",
                        style: TextStyle(
                          // color: kPrimaryBlueColor,
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
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "It's quick and easy",
                                style: TextStyle(fontSize: 14.0),
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
                              validatorFtn: Validators.emailValidator,
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
                              validatorFtn: Validators.phoneNumberValidator,
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
                              validatorFtn: Validators.passwordValidator,
                              onChangeFtn: (value) {
                                setState(() {
                                  _passCheck = value;
                                });
                              },
                              onFieldSubmit: (value) => node.nextFocus(),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle_rounded,
                                      color: Validators.passwordValidator(
                                                  passwordController.text
                                                      .trim()) ==
                                              null
                                          ? Colors.green
                                          : passwordController.text.trim() == ""
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
                                            : passwordController.text.trim() ==
                                                    ""
                                                ? Colors.grey
                                                : Colors.red),
                                  ),
                                  Spacer(),
                                  PopupMenuButton(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Validators.passwordValidator(
                                                  passwordController.text
                                                      .trim()) ==
                                              null
                                          ? Colors.green
                                          : passwordController.text.trim() == ""
                                              ? Colors.grey
                                              : Colors.red,
                                    ),
                                    elevation: 2.0,
                                    itemBuilder: (context) => [
                                      PassCheckRequirements(
                                        passCheck: _passCheck
                                            .contains(RegExp(r'[A-Z]')),
                                        requirement: "1 Uppercase [A-Z]",
                                      ),
                                      PassCheckRequirements(
                                        passCheck: _passCheck
                                            .contains(RegExp(r'[a-z]')),
                                        requirement: "1 lower [a-z]",
                                      ),
                                      PassCheckRequirements(
                                        passCheck: _passCheck
                                            .contains(RegExp(r'[0-9]')),
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
                                    ]
                                        .map((e) => PopupMenuItem(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 8.0),
                                            height: 10.0,
                                            child: e))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 5.0),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       PassCheckRequirements(
                            //         passCheck:
                            //             _passCheck.contains(RegExp(r'[A-Z]')),
                            //         requirement: "1 Uppercase [A-Z]",
                            //       ),
                            //       SizedBox(height: 5.0),
                            //       PassCheckRequirements(
                            //         passCheck:
                            //             _passCheck.contains(RegExp(r'[a-z]')),
                            //         requirement: "1 lower [a-z]",
                            //       ),
                            //       SizedBox(height: 5.0),
                            //       PassCheckRequirements(
                            //         passCheck:
                            //             _passCheck.contains(RegExp(r'[0-9]')),
                            //         requirement: "1 number [0-9]",
                            //       ),
                            //       SizedBox(height: 5.0),
                            //       PassCheckRequirements(
                            //         passCheck: _passCheck.contains(
                            //             RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                            //         requirement:
                            //             "1 special character [@, \$, # etc.]",
                            //       ),
                            //       SizedBox(height: 5.0),
                            //       PassCheckRequirements(
                            //         passCheck: _passCheck.length >= 6,
                            //         requirement: "6 characters minimum",
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
                                fillColor: _themeProvider.darkTheme
                                    ? Colors.black12
                                    : Colors.grey[100],
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
                                          // child: _countryLoaded
                                          //     ? Center(child: kLoader)
                                          //     : DropdownButton(
                                          //         isExpanded: true,
                                          //         value: _country,
                                          //         items: [
                                          //           for (int i = 0;
                                          //               i < _countryNames.length;
                                          //               i++)
                                          //             DropdownMenuItem(
                                          //               value: _countryNames[i],
                                          //               child: Text(
                                          //                 _countryNames[i],
                                          //               ),
                                          //             ),
                                          //         ],
                                          //         onChanged: (value) {
                                          //           setState(() {
                                          //             _country = value;
                                          //           });
                                          //         },
                                          //       ),
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
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.report,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(result,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      backgroundColor: Colors.red,
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
                                      backgroundColor: kSecondaryBlueColor,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    _clearController();

                                    Navigator.pushNamed(
                                        context, "/emailNotVerified");
                                  }
                                }
                              },
                              btnColor: kLightGreenColor,
                              btnText: _isLoading
                                  ? SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      "Sign Up",
                                      style: kBtnTextStyle,
                                    ),
                            ),
                            Text(
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
      ),
    );
  }
}
