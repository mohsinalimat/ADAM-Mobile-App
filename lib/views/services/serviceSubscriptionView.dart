import 'dart:convert';

import 'package:adam/constants.dart';
import 'package:adam/views/mainView.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adam/views/stripe/stripePayment.dart';
import 'package:adam/views/stripe/stripeServer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class ServiceSubscriptionView extends StatefulWidget {
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

  @override
  _ServiceSubscriptionViewState createState() =>
      _ServiceSubscriptionViewState();
}

class _ServiceSubscriptionViewState extends State<ServiceSubscriptionView> {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    _flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onSelectNotification: (payload) {
        return Navigator.pushNamed(context, "/mainView");
      },
    );
    super.initState();
  }

  showNotification() async {
    var android = AndroidNotificationDetails('id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(
      android: android,
      iOS: iOS,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      widget.serviceName,
      'Service has been subscribed successfully!',
      platform,
      payload: 'Welcome to the Local Notification demo',
    );
  }

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

  void sendNotification() async {
    print("SENDING NOTIFICATIONS...!!");
    final postNotificationURL = "https://fcm.googleapis.com/fcm/send";
    final headers = {
      'content-type': 'application/json',
      'Authorization': dotenv.env["authServerKeyFirebase"]
    };
    QuerySnapshot qnSnapshot =
        await FirebaseFirestore.instance.collection('notificationsToken').get();

    for (int i = 0; i < qnSnapshot.docs.length; i++) {
      print("TOKEN SENDING TOOO: " + qnSnapshot.docs[i]['token']);
      final body = {
        "to": qnSnapshot.docs[i]['token'],
        "mutable_content": true,
        "priority": "high",
        "notification": {
          "title": widget.serviceName,
          "body": "New service has been subscribed",
        },
        "data": {
          "body": "body",
          "title": "title",
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
        }
      };
      await http.post(
        Uri.parse(postNotificationURL),
        headers: headers,
        body: json.encode(body),
        encoding: Encoding.getByName('utf-8'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
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
                    backgroundColor: widget.colorTheme,
                    mini: true,
                    heroTag: widget.iconData.toString(),
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
                    Text(widget.serviceName, style: _textTheme.headline1),
                    Text("Campaign"),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(widget.serviceDesc),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                StandardServiceSubscriptionCard(
                  colorTheme: widget.colorTheme,
                  iconData: widget.iconData,
                  standardFeatures: _standardFeatures,
                  subcribe: showNotification,
                  // subcribe: _subscribe,
                ),
                SizedBox(
                  height: 40.0,
                ),
                PremiumServiceSubscriptionCard(
                  colorTheme: widget.colorTheme,
                  iconData: widget.iconData,
                  standardFeatures: _premiumFeatures,
                  subcribe: showNotification,
                  // subcribe: _subscribe,
                ),
                SizedBox(
                  height: 40.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ratings and reviews",
                    style: _textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "4.7",
                      style: _textTheme.headline1,
                    ),
                    Expanded(child: Container()),
                    for (int i = 0; i < 4; i++)
                      Icon(
                        Icons.star_rounded,
                        // color: kPrimaryBlueColor,
                        size: 30.0,
                      ),
                    Icon(
                      Icons.star_half_rounded,
                      // color: kPrimaryBlueColor,
                      size: 30.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                for (int i = 0; i < 3; i++) FeedbackCard(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See all reviews",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/dp.png'),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text("John Doe")
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star_rounded,
                          size: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert_outlined),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Text(
              "Really helpful, got my business started with this service. I am glad I found this on internet. Really afforadable and awesome results! 100% recommended!",
            ),
          )
        ],
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
    this.subcribe,
  })  : _standardFeatures = standardFeatures,
        super(key: key);

  final Color colorTheme;
  final IconData iconData;
  final List<ServiceFeatureWidget> _standardFeatures;
  final Function subcribe;

  // void _subscribe() async {
  //   final sessionId = await StripeServer(
  //     serviceName: "Service Name",
  //     price: 3000,
  //   ).createCheckout();

  //   print("SESSION ID $sessionId");

  //   final result = await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) => StripePaymentCheckout(
  //         sessionId: sessionId,
  //       ),
  //     ),
  //   );
  //   SnackBar snackbar;
  //   if (result == "success") {
  //     snackbar = SnackBar(
  //       content: paymentSuccessful,
  //     );
  //   } else {
  //     snackbar = SnackBar(
  //       content: paymentCanceled,
  //     );
  //   }
  //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
  // }

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
            kMediumBlueColor,
            kMediumGreenColor,
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
            btnOnPressed: subcribe,
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
    this.subcribe,
    @required List<ServiceFeatureWidget> standardFeatures,
  })  : _standardFeatures = standardFeatures,
        super(key: key);

  final Color colorTheme;
  final IconData iconData;
  final List<ServiceFeatureWidget> _standardFeatures;
  final Function subcribe;

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
            kMediumBlueColor,
            kMediumGreenColor,
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
            btnOnPressed: subcribe,
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
