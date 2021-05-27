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
      height: 280,
      width: 200,
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
                  height: 20.0,
                  width: 120,
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
            Column(
              children: [
                Icon(
                  serviceIcon,
                  color: kPrimaryBlueColor,
                  size: 40.0,
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
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 40,
              child: isRunning
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                            LinearProgressIndicator(
                              minHeight: 10.0,
                              color: kLightGreenColor,
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
              btnWidth: 150,
              btnHeight: 30.0,
              btnOnPressed: () {},
              btnColor: kPrimaryBlueColor,
              btnText: Text(
                "Details",
                style: kBtnTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
