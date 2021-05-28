import 'package:adam/constants.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';

class ServiceSubscriptionView extends StatelessWidget {
  final String serviceName;
  final IconData iconData;
  final Color colorTheme;
  final String serviceDesc;

  ServiceSubscriptionView({
    Key key,
    this.serviceName,
    this.serviceDesc,
    this.iconData,
    this.colorTheme,
  }) : super(key: key);

  final _standardFeatures = [
    ServiceFeatureWidget(
      featureText: "Best Facebook Bot",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Quick & Easy Setup",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Targeted Audience",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Inbox Messages",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Group Posting",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Auto Status Posting",
      isChecked: false,
    ),
    ServiceFeatureWidget(
      featureText: "Auto Reply",
      isChecked: false,
    ),
    ServiceFeatureWidget(
      featureText: "Auto Comments",
      isChecked: false,
    ),
  ];

  final _premiumFeatures = [
    ServiceFeatureWidget(
      featureText: "Best Facebook Bot",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Quick & Easy Setup",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Targeted Audience",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Inbox Messages",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Group Posting",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Auto Status Posting",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Auto Reply",
      isChecked: true,
    ),
    ServiceFeatureWidget(
      featureText: "Auto Comments",
      isChecked: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 25.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FloatingActionButton(
                    elevation: 0.0,
                    backgroundColor: colorTheme,
                    mini: true,
                    heroTag: iconData.toString(),
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      serviceName,
                      style: TextStyle(
                          color: colorTheme,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                    ),
                    Text(
                      "Campaign",
                      style: TextStyle(
                        color: colorTheme,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      serviceDesc,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                StandardServiceSubscriptionCard(
                  colorTheme: colorTheme,
                  iconData: iconData,
                  standardFeatures: _standardFeatures,
                ),
                SizedBox(
                  height: 40.0,
                ),
                PremiumServiceSubscriptionCard(
                  colorTheme: colorTheme,
                  iconData: iconData,
                  standardFeatures: _premiumFeatures,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StandardServiceSubscriptionCard extends StatelessWidget {
  const StandardServiceSubscriptionCard({
    Key key,
    @required this.colorTheme,
    @required this.iconData,
    @required List<ServiceFeatureWidget> standardFeatures,
  })  : _standardFeatures = standardFeatures,
        super(key: key);

  final Color colorTheme;
  final IconData iconData;
  final List<ServiceFeatureWidget> _standardFeatures;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      width: 275,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorTheme == kMediumGreenColor
                ? kMediumBlueColor
                : kMediumGreenColor,
            colorTheme,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServiceSubscriptionTop(
            iconData: iconData,
            price: "89",
          ),
          SizedBox(height: 15.0),
          Text(
            "An affordable entry point for anyone looking to grow their business via Facebook.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15.0),
          for (int i = 0; i < _standardFeatures.length; i++)
            _standardFeatures[i],
          SizedBox(height: 15.0),
          CustomButton(
            btnWidth: MediaQuery.of(context).size.width,
            btnHeight: 40.0,
            btnOnPressed: () {},
            btnColor: kLightBlueColor,
            btnText: Text(
              "Subscribe",
              style: kBtnTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumServiceSubscriptionCard extends StatelessWidget {
  const PremiumServiceSubscriptionCard({
    Key key,
    @required this.colorTheme,
    @required this.iconData,
    @required List<ServiceFeatureWidget> standardFeatures,
  })  : _standardFeatures = standardFeatures,
        super(key: key);

  final Color colorTheme;
  final IconData iconData;
  final List<ServiceFeatureWidget> _standardFeatures;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      width: 275,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorTheme == kMediumGreenColor
                ? kMediumBlueColor
                : kMediumGreenColor,
            colorTheme,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServiceSubscriptionTop(
            iconData: iconData,
            price: "129",
            isPremeium: true,
          ),
          SizedBox(height: 15.0),
          Text(
            "An affordable entry point for anyone looking to grow their business via Facebook.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15.0),
          for (int i = 0; i < _standardFeatures.length; i++)
            _standardFeatures[i],
          SizedBox(height: 15.0),
          CustomButton(
            btnWidth: MediaQuery.of(context).size.width,
            btnHeight: 40.0,
            btnOnPressed: () {},
            btnColor: kLightBlueColor,
            btnText: Text(
              "Subscribe",
              style: kBtnTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceFeatureWidget extends StatelessWidget {
  ServiceFeatureWidget({
    Key key,
    this.featureText,
    this.isChecked,
  }) : super(key: key);

  final String featureText;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_box,
            color: isChecked ? kLightGreenColor : Colors.grey[300],
            size: 22.0,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            featureText,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class ServiceSubscriptionTop extends StatelessWidget {
  const ServiceSubscriptionTop({
    Key key,
    @required this.iconData,
    this.isPremeium = false,
    @required this.price,
  }) : super(key: key);

  final IconData iconData;
  final bool isPremeium;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          size: 50.0,
          color: Colors.white,
        ),
        SizedBox(width: 10.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\$$price/",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "month",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(height: 3.0),
            Diagonal(
              clipHeight: 20.0,
              axis: Axis.vertical,
              position: DiagonalPosition.TOP_RIGHT,
              child: Diagonal(
                clipHeight: 20.0,
                axis: Axis.vertical,
                position: DiagonalPosition.BOTTOM_RIGHT,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  height: 20.0,
                  width: 100,
                  color: isPremeium ? kLightGreenColor : kLightBlueColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isPremeium ? "Premium" : "Standard",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
