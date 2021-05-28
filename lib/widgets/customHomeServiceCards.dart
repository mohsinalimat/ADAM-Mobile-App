import 'package:adam/constants.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';

class YourServiceCard extends StatelessWidget {
  const YourServiceCard({
    Key key,
    this.isRunning = false,
    this.isPremium = false,
    @required this.serviceIcon,
    @required this.serviceTitle,
  }) : super(key: key);
  final bool isRunning;
  final bool isPremium;
  final IconData serviceIcon;
  final String serviceTitle;
  @override
  Widget build(BuildContext context) {
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
                  )),
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
                      color: kPrimaryBlueColor,
                      size: 60.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    serviceTitle,
                    style: kSubHeadingStyle,
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
              child: isRunning
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "In Progress...",
                              style: TextStyle(color: kPrimaryBlueColor),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Expanded(
                              child: LinearProgressIndicator(
                                color: kLightGreenColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        "Serivce Not Running!",
                        style: TextStyle(
                          color: kPrimaryBlueColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                    style: kSubHeadingStyle,
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
                style: kBtnTextStyle,
              ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
