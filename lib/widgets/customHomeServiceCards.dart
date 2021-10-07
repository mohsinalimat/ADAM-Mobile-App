import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/views/services/email/email_marketing_view.dart';
import 'package:adam/views/services/instagram/instagram_view.dart';
import 'package:adam/views/services/linkedin/linkedin_view.dart';
import 'package:adam/views/services/sms/sms_marketing_view.dart';
import 'package:adam/views/services/twitter/twitter_view.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourServiceCard extends StatelessWidget {
  final bool isRunning;
  final bool isPremium;
  final IconData serviceIcon;
  final String serviceTitle;

  const YourServiceCard({
    Key key,
    this.isRunning = false,
    this.isPremium = false,
    @required this.serviceIcon,
    @required this.serviceTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    final _textTheme = Theme.of(context).textTheme;
    return SizedBox(
      // height: 350,
      width: 260,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 8.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Diagonal(
                clipHeight: 20.0,
                axis: Axis.vertical,
                position: DiagonalPosition.TOP_RIGHT,
                child: Container(
                  height: 30.0,
                  width: 150,
                  color: isPremium ? kLightGreenColor : kLightBlueColor,
                  child: Center(
                    child: Text(
                      isPremium ? "Premium" : "Standard",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Icon(
                      serviceIcon,
                      // color: kPrimaryBlueColor,
                      size: 60.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    serviceTitle,
                    style: _textTheme.headline2,
                  ),
                  Text("Campaign"),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: isRunning
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("In Progress..."),
                            const SizedBox(height: 8.0),
                            Expanded(
                              child: LinearProgressIndicator(
                                valueColor: _themeProvider.darkTheme
                                    ? AlwaysStoppedAnimation<Color>(
                                        kMediumGreenColor)
                                    : AlwaysStoppedAnimation<Color>(
                                        kLightGreenColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        "Serivce Not Running!",
                        // style: _textTheme.bodyText2,
                      ),
                    ),
            ),
            SizedBox(height: 20.0),
            CustomButton(
              btnWidth: 200,
              btnHeight: 40.0,
              btnOnPressed: () {
                if (serviceTitle == "Instagram Marketing") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InstagramView(
                        isPrem: isPremium,
                      ),
                    ),
                  );
                } else if (serviceTitle == "Twitter Marketing") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TwitterView(
                        isPrem: isPremium,
                      ),
                    ),
                  );
                } else if (serviceTitle == "LinkedIn Marketing") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LinkedinView(
                        isPrem: isPremium,
                      ),
                    ),
                  );
                } else if (serviceTitle == "Email Marketing") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EmailMarketingView(),
                    ),
                  );
                } else if (serviceTitle == "SMS Marketing") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SMSMarketingView(),
                    ),
                  );
                }
              },
              btnColor: _themeProvider.darkTheme
                  ? kMediumBlueColor
                  : kPrimaryBlueColor,
              btnText: Text(
                "Details",
                style: kBtnTextStyle,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}

class MoreServiceCard extends StatelessWidget {
  const MoreServiceCard({
    Key key,
    @required this.serviceIcon,
    @required this.serviceTitle,
    this.premiumAvailable = true,
    this.price,
  }) : super(key: key);
  final IconData serviceIcon;
  final String serviceTitle;
  final bool premiumAvailable;
  final String price;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 280,
      width: 260,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Icon(
                      serviceIcon,
                      color: kPrimaryBlueColor,
                      size: 60.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    serviceTitle,
                    // style: kSubHeadingStyle,
                  ),
                  Text(
                    "Campaign",
                    style: TextStyle(
                      color: kPrimaryBlueColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Starting from \$$price ",
                        style: TextStyle(
                            color: kPrimaryBlueColor,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: premiumAvailable ? "Premium" : "Standard",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: premiumAvailable
                            ? kLightGreenColor
                            : kLightBlueColor,
                      ),
                    ),
                    TextSpan(
                        text: " Available",
                        style: TextStyle(
                            color: kPrimaryBlueColor,
                            fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CustomButton(
              btnWidth: 200,
              btnHeight: 40.0,
              btnOnPressed: () {},
              btnColor: kPrimaryBlueColor,
              btnText: Text(
                "Subscribe",
                // style: kBtnTextStyle,
              ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
