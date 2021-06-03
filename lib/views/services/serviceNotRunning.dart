import 'package:adam/constants.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:flutter/material.dart';

class ServiceNotRunning extends StatelessWidget {
  final String serviceName;

  const ServiceNotRunning({Key key, this.serviceName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
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
            Expanded(child: Container()),
            Text(
              serviceName,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 10.0),
            Text("No progress, service not started!"),
            SizedBox(height: 20.0),
            CustomButton(
              btnWidth: 200.0,
              btnHeight: 40.0,
              btnColor: kLightBlueColor,
              btnOnPressed: () {},
              btnText: Text(
                "Start!",
                style: kBtnTextStyle,
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      )),
    );
  }
}
