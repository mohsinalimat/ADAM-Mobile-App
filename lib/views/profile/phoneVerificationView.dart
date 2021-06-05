import 'dart:async';

import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PhoneVerificationView extends StatefulWidget {
  final String phoneNumber;

  PhoneVerificationView({
    Key key,
    this.phoneNumber,
  }) : super(key: key);
  @override
  _PhoneVerificationViewState createState() => _PhoneVerificationViewState();
}

class _PhoneVerificationViewState extends State<PhoneVerificationView> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _codeController = TextEditingController();

  Timer _timer;
  int _start = 59;
  String _verificationId;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future verifyPhoneNumber(String phoneNumber, BuildContext context) async {
    String newPhone = phoneNumber;

    // Incase there is no country code +92 in front of the number
    if (phoneNumber.substring(0, 1) != "+") {
      String tempPhone = phoneNumber.substring(1, phoneNumber.length);
      newPhone = "+92$tempPhone";
    }
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: newPhone,
      verificationCompleted: (PhoneAuthCredential phoneCred) {
        print("Phone number verified!");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("EXCEPTION: ${e.code}");
        var snackBar = SnackBar(
          backgroundColor: Colors.red[700],
          content: Row(
            children: [
              Icon(Icons.check, color: Colors.white),
              SizedBox(
                width: 8.0,
              ),
              Text(
                "Verification failed: ${e.code}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return e.code;
      },
      codeSent: (String verificationId, int resendToken) {
        print("CODE SENT!");
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: _codeController.text.trim(),
        );
        _verificationId = verificationId;
        FirebaseFirestore.instance
            .collection('user')
            .doc(_firebaseAuth.currentUser.uid)
            .update({
          "phoneVerify": true,
        });
        var snackBar = SnackBar(
          backgroundColor: kMediumBlueColor,
          content: Row(
            children: [
              Icon(Icons.check, color: Colors.white),
              SizedBox(
                width: 8.0,
              ),
              Text(
                "Phone Number Verified successfully!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(phoneAuthCredential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        return _verificationId = verificationId;
      },
      timeout: Duration(seconds: 60),
    );
  }

  _verifyCode() {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _codeController.text.trim(),
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(_firebaseAuth.currentUser.uid)
        .update({
      "phoneVerify": true,
    });
    var snackBar = SnackBar(
      backgroundColor: kMediumBlueColor,
      content: Row(
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "Phone Number Verified successfully!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(phoneAuthCredential);
  }

  @override
  void initState() {
    startTimer();
    verifyPhoneNumber(widget.phoneNumber, context);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(
                    color: kPrimaryBlueColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Image.asset(
                  'assets/phoneVerify.gif',
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  "Phone Number Verification",
                  style: TextStyle(
                    color: kPrimaryBlueColor,
                    fontWeight: FontWeight.bold,
                    // fontSize: height * 0.04,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Wait for auto-detection! Code sent to ",
                        style: TextStyle(color: kPrimaryBlueColor)),
                    TextSpan(
                        text: widget.phoneNumber,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryBlueColor)),
                  ]),
                ),
                SizedBox(
                  height: 20.0,
                ),
                PinCodeTextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  textStyle: Provider.of<ThemeProvider>(context).darkTheme
                      ? TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        )
                      : TextStyle(fontSize: 14.0),
                  appContext: context,
                  length: 6,
                  onChanged: (value) {},
                  pinTheme: PinTheme(
                    fieldWidth: 25.0,
                    fieldOuterPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    inactiveColor: kPrimaryBlueColor,
                    activeColor: kMediumGreenColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Timeout: ",
                        style: TextStyle(color: kPrimaryBlueColor)),
                    TextSpan(
                        text: _start == 0 ? "Code Expired!" : "00:$_start",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryBlueColor)),
                  ]),
                ),
                SizedBox(
                  height: 20.0,
                ),
                CustomButton(
                  btnWidth: width * 0.8,
                  btnHeight: 40.0,
                  btnOnPressed: () => _verifyCode(),
                  btnColor: kMediumGreenColor,
                  btnText: Text(
                    "Verify",
                    style: kBtnTextStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
