import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/logoDisplay.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnGoingServiceView extends StatelessWidget {
  final String serviceName;

  const OnGoingServiceView({Key key, this.serviceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                  LogoDisplay()
                ],
              ),
              SizedBox(height: 30.0),
              Text(
                serviceName,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 15.0),
              SizedBox(
                height: 30.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "In Progress...",
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        valueColor: _themeProvider.darkTheme
                            ? AlwaysStoppedAnimation<Color>(kMediumGreenColor)
                            : AlwaysStoppedAnimation<Color>(kLightGreenColor),
                        // color: _themeProvider.darkTheme
                        //     ? kMediumGreenColor
                        //     : kLightGreenColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Target Profile/Page: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _themeProvider.darkTheme
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  TextSpan(
                      text: "@mhamzadev",
                      style: TextStyle(
                        color: _themeProvider.darkTheme
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      )),
                ]),
              ),
              SizedBox(height: 15.0),
              Card(
                child: Container(
                  height: 100.0,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        // backgroundImage:
                        //     FirebaseAuth.instance.currentUser.photoURL == " "
                        //         ? AssetImage('assets/dp.png')
                        //         : NetworkImage(
                        //             FirebaseAuth.instance.currentUser.photoURL),
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "https://instagram.com/mhamzadev",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .fontSize,
                                color: _themeProvider.darkTheme
                                    ? Colors.white.withAlpha(150)
                                    : Theme.of(context)
                                        .primaryColor
                                        .withAlpha(150)),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Username: ",
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: _themeProvider.darkTheme
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                              TextSpan(
                                  text: "@mhamzadev",
                                  style: TextStyle(
                                    color: _themeProvider.darkTheme
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                  )),
                            ]),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Followers: ",
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: _themeProvider.darkTheme
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                              TextSpan(
                                  text: "14.2 k",
                                  style: TextStyle(
                                    color: _themeProvider.darkTheme
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                  )),
                            ]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Action(s): ",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                      fontWeight: FontWeight.bold,
                      color: _themeProvider.darkTheme
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  TextSpan(
                      text: "Followers",
                      style: TextStyle(
                        color: _themeProvider.darkTheme
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      )),
                ]),
              ),
              SizedBox(height: 25.0),
              Text("Your progress:"),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Icon(Icons.group),
                  Text(
                    " Total followers: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headline2.fontSize,
                    ),
                  ),
                  Text(
                    "12,203",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline2.fontSize,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(Icons.check),
                  Text(
                    " Targets reached: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headline2.fontSize,
                    ),
                  ),
                  Text(
                    "1,003",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline2.fontSize,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(Icons.timelapse_sharp),
                  Text(
                    " Time elapse: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headline2.fontSize,
                    ),
                  ),
                  Text(
                    "02:10:45",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline2.fontSize,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              CustomButton(
                btnWidth: MediaQuery.of(context).size.width,
                btnHeight: 40.0,
                btnOnPressed: () {},
                btnColor: Colors.red,
                btnText: Text(
                  "Stop",
                  style: kBtnTextStyle,
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
