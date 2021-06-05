import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailNotVerfied extends StatefulWidget {
  @override
  _EmailNotVerfiedState createState() => _EmailNotVerfiedState();
}

class _EmailNotVerfiedState extends State<EmailNotVerfied> {
  final _auth = Auth();

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            SvgPicture.asset(
              'assets/changeEmail.svg',
              height: 100.0,
            ),
            Text(
              "Looks like your email is not verified yet.\nPlease verify your email!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 15.0),
            CustomButton(
              btnWidth: 200.0,
              btnHeight: 40.0,
              btnOnPressed: () {
                _firebaseAuth.currentUser.reload().whenComplete(() {
                  setState(() {});
                });

                _emailVerify();
              },
              btnColor: kPrimaryBlueColor,
              btnText: Text(
                "Verify",
                style: kBtnTextStyle,
              ),
            ),
            TextButton(onPressed: _resendEmail, child: Text("Resend email")),
            Expanded(child: Container()),
            TextButton(
              onPressed: () {
                var snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Row(
                    children: [
                      Icon(Icons.check, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text(
                        "Sign Out Successful!",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                _auth.signOut(context);
              },
              child: Text("Logout"),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  void _emailVerify() {
    Future.delayed(Duration(seconds: 2), () {
      if (_firebaseAuth.currentUser.emailVerified) {
        var snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Row(
            children: [
              Icon(
                Icons.check,
                color: Colors.white,
              ),
              SizedBox(width: 5.0),
              Text("Congratulations! Your email is verfied."),
            ],
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushNamedAndRemoveUntil(
            context, '/mainView', (route) => false);
      } else {
        var snackBar = SnackBar(
          backgroundColor: Colors.red[700],
          content: Row(
            children: [
              Icon(
                Icons.report,
                color: Colors.white,
              ),
              SizedBox(width: 5.0),
              Text("Email is not verfied yet!"),
            ],
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void _resendEmail() {
    _firebaseAuth.currentUser.sendEmailVerification();
    var snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.email,
            color: Colors.white,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
                "Verification link sent: ${_firebaseAuth.currentUser.email}"),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
