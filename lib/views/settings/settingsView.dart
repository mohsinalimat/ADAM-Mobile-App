import 'package:adam/auth/userAuth.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class SettingsView extends StatelessWidget {
  final _userAuth = UserAuth();

  final _settingsOptionsIcons = [
    Icons.vpn_key_rounded,
    Icons.notifications_rounded,
    Icons.help_outline_rounded,
    Icons.brightness_6,
  ];

  final _settingsOptions = ['Account', "Notifications", "Help", "Theme"];

  final _settingsOptionsSubtitles = [
    "Change password, Delete account",
    "Enable/Disable, Change tone",
    "FAQs, Privacy Policy, App info",
    "Dark mode, Font size"
  ];

  final _settingsOptionsRoutes = [
    '/account',
    '/notifications',
    '/help',
    '/theme',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: _settingsOptionsIcons
                      .map((e) => Icon(e))
                      .elementAt(index),
                  title: _settingsOptions.map((e) => Text(e)).elementAt(index),
                  subtitle: _settingsOptionsSubtitles
                      .map((e) => Text(e))
                      .elementAt(index),
                  onTap: () => Navigator.pushNamed(context,
                      _settingsOptionsRoutes.map((e) => e).elementAt(index)),
                );
              },
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
            const Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              subtitle: Text("See you soon!"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => LogoutAlertBox(
                    signOut: _signOut,
                  ),
                );
              },
            ),
            const SizedBox(height: 30.0),
            const LogoDisplay(),
          ],
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    var snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        children: [
          const Icon(Icons.check, color: Colors.white),
          const SizedBox(width: 8.0),
          const Text(
            "Sign Out Successful!",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );

    // await _auth.signOut(context);
    Navigator.popUntil(context, (route) => route.settings?.name == "/");
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    await _userAuth.logout(context);
  }
}

class LogoutAlertBox extends StatelessWidget {
  final void Function(BuildContext context) signOut;

  const LogoutAlertBox({Key key, @required this.signOut}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Logout",
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline2.fontSize,
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
          child: const Text(
            "Yes",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => signOut(context),
        ),
        TextButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
