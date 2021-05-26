import 'package:adam/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: TextButton(
        child: Text("Sign Out"),
        onPressed: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          FirebaseAuth.instance.signOut();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kSecondaryBlueColor,
              behavior: SnackBarBehavior.floating,
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
                    "Sign Out Successful!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
          preferences.remove("userId");
          Navigator.popUntil(context, (route) => route.settings.name == "/");
        },
      )),
    );
  }
}
