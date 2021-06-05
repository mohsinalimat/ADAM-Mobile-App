import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/views/settings/settingsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  final _auth = Auth();
  
  final _drawerOptions = [
    "Account",
    "Subscription History",
    "Live Chat",
    "Help",
  ];

  final _drawerOptionsIcons = [
    Icons.person,
    Icons.history_rounded,
    Icons.chat_rounded,
    Icons.help_outline_outlined,
  ];

  final _drawerOptionsFtn = [
    "/account",
    "/subscriptionHistory",
    "/chat",
    "/help",
  ];

  @override
  Widget build(BuildContext context) {
    final _themeProvder = Provider.of<ThemeProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _themeProvder.darkTheme
              ? [
                  Colors.black,
                  Colors.white.withAlpha(10),
                ]
              : [
                  kMediumGreenColor,
                  kPrimaryBlueColor,
                ],
        ),
      ),
      child: ScaffoldMessenger(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 20.0),
                      SvgPicture.asset(
                        'assets/logo/logoWhite.svg',
                        height: 50.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Automated Digital Assistant in Marketing",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Divider(color: Colors.white),
                      SizedBox(
                        height: 225,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _drawerOptions.length,
                          itemBuilder: (context, index) => ListTile(
                            minLeadingWidth: 10.0,
                            leading: Icon(_drawerOptionsIcons[index],
                                color: Colors.white),
                            title: Text(
                              _drawerOptions[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () => Navigator.pushNamed(
                                context, _drawerOptionsFtn[index]),
                          ),
                        ),
                      ),
                      ListTile(
                        minLeadingWidth: 10.0,
                        leading: Icon(
                          _themeProvder.darkTheme
                              ? Icons.brightness_2_rounded
                              : Icons.wb_sunny_rounded,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Dark mode',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Switch(
                          value: _themeProvder.darkTheme,
                          onChanged: (value) => _themeProvder.darkTheme = value,
                        ),
                      ),
                      Divider(color: Colors.white),
                      ListTile(
                        minLeadingWidth: 10.0,
                        leading: Icon(
                          Icons.exit_to_app_rounded,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                LogoutAlertBox(signOut: _signOut),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: -40,
                child: SvgPicture.asset(
                  'assets/logo/logoA.svg',
                  height: 200.0,
                  color: Colors.white.withAlpha(50),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  void _signOut(BuildContext context) {
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
    _auth.signOut(context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
