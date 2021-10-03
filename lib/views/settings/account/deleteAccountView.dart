import 'package:adam/auth/userAuth.dart';
import 'package:adam/constants.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeleteAccountView extends StatefulWidget {
  @override
  _DeleteAccountViewState createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final UserAuth _userAuth = UserAuth();
  // Auth _auth = Auth();
  // FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _deleting = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AbsorbPointer(
        absorbing: _deleting,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
              child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BackButton(
                        color: Colors.red,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SvgPicture.asset(
                      'assets/delete.svg',
                      height: 100,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text(
                      "Delete Account!",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        // fontSize: height * 0.04,
                        fontSize: 28.0,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      "Enter your password for verfication purposes!",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: height * 0.1),
                    CustomTextField(
                      isPassword: true,
                      textEditingController: _passwordController,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: "Enter Password",
                      icon: Icons.lock,
                      iconColor: Colors.red,
                      passIconColor: Colors.red,
                      validatorFtn: (value) {
                        if (value.isEmpty) {
                          return "Password cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    CustomButton(
                      btnWidth: width * 0.5,
                      btnHeight: 40.0,
                      btnOnPressed: _deleteAccount,
                      btnColor: Colors.red,
                      btnText: _deleting
                          ? kLoaderWhite
                          : Text(
                              "Confirm Password",
                              style: kBtnTextStyle,
                            ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      "* This process is irreversible. All your data will be lost!",
                      style: TextStyle(color: Colors.red, fontSize: 12.0),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }

  void _deleteAccount() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();

      setState(() {
        _deleting = true;
      });
      int code = await _userAuth
          .deleteAccount(_passwordController.text.trim())
          .whenComplete(() {
        setState(() {
          _deleting = false;
        });
      });
      print("CODE $code");
      if (code == 200) {
        if (mounted) {
          customSnackBar(
              context,
              kSecondaryBlueColor,
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.white),
                  const SizedBox(width: 8.0),
                  const Text('Account has been deleted successfully!')
                ],
              ));
          Navigator.popUntil(context, (route) => route.settings.name == "/");
        }
      } else if (code == 204) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text('Password Mismatched!')
            ],
          ),
        );
      } else {
        customSnackBar(
            context,
            Colors.red,
            Row(
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: 8.0),
                const Text('Unexpected error!')
              ],
            ));
      }
    }
  }
}
