import 'dart:async';

import 'package:adam/constants.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
  Timer _timer;
  int _start = 59;
  final _codeController = TextEditingController();

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

  @override
  void initState() {
    startTimer();
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
                        text: "Enter 6-Digit Code sent to ",
                        style: TextStyle(color: kPrimaryBlueColor)),
                    TextSpan(
                        text: "+923460159889",
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
                  textStyle: TextStyle(fontSize: 14.0),
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
                        text: "Timout: ",
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
                  btnOnPressed: () {},
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
