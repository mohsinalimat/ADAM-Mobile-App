import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationBadge extends StatelessWidget {
  final bool isEmailType;

  const VerificationBadge({Key key, @required this.isEmailType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.verified, color: kLightBlueColor),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  isEmailType ? "Email Verification" : "Phone Verification",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline2.fontSize,
                    color: Provider.of<ThemeProvider>(context).darkTheme
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
            content: Text(
              isEmailType
                  ? "Congratulations!\nYour email address is verified."
                  : "Congratulations!\nYour phone number is verified.",
            ),
          ),
        );
      },
      child: Icon(
        Icons.verified,
        color: kLightBlueColor,
      ),
    );
  }
}

class PhoneNotVerified extends StatelessWidget {
  final String phoneNumber;

  const PhoneNotVerified({Key key, @required this.phoneNumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.verified, color: Colors.grey),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Phone Verification",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline2.fontSize,
                    color: Provider.of<ThemeProvider>(context).darkTheme
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
            content: Text(
              "Opss!\nYour phone is not verified!\n\nIf you want to proceed, please make sure that SIM Card respective to your phone number must be in your device otherwise verification will be failed as its based on auto-detection.",
              textAlign: TextAlign.justify,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) =>
                  //         PhoneVerificationView(phoneNumber: phoneNumber),
                  //   ),
                  // );
                },
                child: Text("Verify Now!"),
              )
            ],
          ),
        );
      },
      child: Icon(
        Icons.info,
        color: Colors.yellow[600],
      ),
    );
  }
}
