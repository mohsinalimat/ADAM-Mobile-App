import 'package:adam/app_routes.dart';
import 'package:adam/auth/user_auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/utils/main_imports.dart';
import 'package:adam/validators/validators.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _userAuth = UserAuth();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

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

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
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
                        SizedBox(height: 60.0),
                        Hero(
                          tag: 'logo',
                          child: SvgPicture.asset(
                            "assets/logo/logoColor.svg",
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Hero(
                          tag: 'logoText',
                          child: Material(
                            child: const Text(
                              "Automated Digital Assistant in Marketing",
                              style: const TextStyle(
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80.0),
                        CustomTextField(
                          hintText: "Enter Email",
                          icon: Icons.email,
                          node: node,
                          onChangeFtn: (value) => print(value),
                          onEditComplete: () => node.nextFocus(),
                          textEditingController: emailTextController,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                          validatorFtn: Validators.emailValidator,
                        ),
                        const SizedBox(height: 15.0),
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
                        const SizedBox(height: 30.0),
                        CustomButton(
                          btnWidth: 300.0,
                          btnHeight: 40,
                          node: node,
                          btnColor: _themeProvider.darkTheme
                              ? kMediumBlueColor
                              : kPrimaryBlueColor,
                          btnText: _isLoading
                              ? kLoaderWhite
                              : const Text(
                                  "Login",
                                  style: kBtnTextStyle,
                                ),
                          btnOnPressed: _login,
                        ),
                        TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.forgotPassword),
                            child: Text("Forgot Password?")),
                        Text(
                          "_________________________________________\n",
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        CustomButton(
                          btnWidth: 250.0,
                          btnHeight: 40,
                          btnOnPressed: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 750),
                              reverseTransitionDuration:
                                  Duration(milliseconds: 750),
                              transitionsBuilder: (context, ani1, ani2, child) {
                                return FadeTransition(
                                  child: child,
                                  opacity: ani1,
                                );
                              },
                              pageBuilder: (context, a1, a2) => SignUpView(),
                            ),
                          ),
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
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      setState(() {
        _isLoading = true;
      });

      int result = await _userAuth
          .login(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
      )
          .whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
      if (result == 200) {
        emailTextController.clear();
        passwordTextController.clear();
        Navigator.pushNamed(context, AppRoutes.dashboard);
      } else if (result == 204) {
        _errorLogin("Account does not exists!");
      } else if (result == 205) {
        _errorLogin("Email/Password does not match!");
      } else if (result == 401) {
        _errorLogin("Token Expired!");
      } else {
        _errorLogin("Undefined error!");
      }
    }
  }

  void _errorLogin(String value) {
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Exit Application",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline1.fontSize,
                color: Provider.of<ThemeProvider>(context).darkTheme
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            content: const Text(
              "Are You Sure?",
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )) ??
        false;
  }
}
