import 'package:adam/constants.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.vpn_key_rounded),
              title: Text("Account"),
              subtitle: Text("Change password, Delete account"),
              onTap: () => Navigator.pushNamed(context, "/account"),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
              subtitle: Text("Enable/disable, Change tone"),
              onTap: () => Navigator.pushNamed(context, "/notifications"),
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text("Help"),
              subtitle: Text("FAQs, Privacy Policy, Terms of Service"),
              onTap: () => Navigator.pushNamed(context, "/help"),
            ),
            ListTile(
              leading: Icon(Icons.brightness_6_rounded),
              title: Text("Theme"),
              subtitle: Text("Dark mode, Font size"),
              onTap: () => Navigator.pushNamed(context, "/theme"),
            ),
            ListTile(
                leading: Icon(Icons.group),
                title: Text("Invite a friend"),
                onTap: () {
                  Share.share(
                      "Uplift your business game with best marketing bots now!\n\n"
                      "https://play.google.com/store/apps/details?id=com.hmz.al_quran \n\nStart marketing as low as \$49/month! :)",
                      subject: "ADAM App");
                }),
            Divider(
              color: Colors.grey,
              // height: 25.0,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              subtitle: Text("See you soon!"),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                FirebaseAuth.instance.signOut();
                var snackBar = SnackBar(
                  backgroundColor: kMediumGreenColor,
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    children: [
                      Icon(Icons.info, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text(
                        "Sign Out Successful!",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                preferences.remove("userId");
                Navigator.popUntil(
                    context, (route) => route.settings.name == "/");
              },
            ),
            SizedBox(height: 30.0),
            LogoDisplay(),
            SizedBox(height: 10.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Version",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(" v 0.0.1")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
