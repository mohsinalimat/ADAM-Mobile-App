import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/validators/validators.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _auth = Auth();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  _testingValues() {
    emailTextController.text = 'hamza.6.shakeel@gmail.com';
    passwordTextController.text = 'Hamza@1';
  }

  @override
  void initState() {
    _testingValues();
    super.initState();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
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
        child: Scaffold(
            body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      SvgPicture.asset(
                        "assets/logo/logoColor.svg",
                        height: 50.0,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Automated Digital Assitant in Marketing",
                        style: const TextStyle(
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
                        validatorFtn: Validators.emailValidator,
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
                        btnHeight: 40,
                        node: node,
                        btnColor: _themeProvider.darkTheme
                            ? kMediumBlueColor
                            : kPrimaryBlueColor,
                        btnText: _isLoading
                            ? kLoader
                            : Text(
                                "Login",
                                style: kBtnTextStyle,
                              ),
                        btnOnPressed: () async {
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _isLoading = true;
                            });

                            var value = await _auth
                                .login(emailTextController.text.trim(),
                                    passwordTextController.text.trim())
                                .whenComplete(() {
                              setState(() {
                                _isLoading = false;
                              });
                            });

                            if (value is String) {
                              _errorLogin(value);
                            } else {
                              Navigator.pushNamed(context, "/mainView");
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
                          onPressed: () =>
                              Navigator.pushNamed(context, "/forgotPassword"),
                          child: Text("Forgot Password?")),
                      Text(
                        "_________________________________________\n",
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      CustomButton(
                        btnWidth: width * 0.6,
                        btnHeight: 40,
                        // btnHeight: height * 0.055,
                        btnOnPressed: () =>
                            Navigator.pushNamed(context, "/signUp"),
                        btnColor: kLightGreenColor,
                        btnText: Text(
                          "Create New Account",
                          style: kBtnTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  void _errorLogin(String value) {
    print("Error: " + value);
    var snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.red[700],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
