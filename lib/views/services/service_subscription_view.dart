import 'package:adam/constants.dart';
import 'package:adam/controller/serviceController.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/model/service.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/views/services/userAllReviews.dart';
import 'package:adam/views/stripe/stripePayment.dart';
import 'package:adam/views/stripe/stripeServer.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/feedbackCard.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class ServiceSubscriptionView extends StatefulWidget {
  final Service service;

  ServiceSubscriptionView({
    Key key,
    this.service,
  }) : super(key: key);

  @override
  _ServiceSubscriptionViewState createState() =>
      _ServiceSubscriptionViewState();
}

class _ServiceSubscriptionViewState extends State<ServiceSubscriptionView> {
  final _reviewController = TextEditingController();
  final ServiceController serviceController = ServiceController();

  // for reviews
  String firstName = "";
  String lastName = "";
  double _ratings = 0;

  bool _isSubscribingStand = false;
  bool _isSubscribingPrem = false;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int standardPrice = 89;
  int premiumPrice = 129;

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

  final _standardFeatures = [
    ServiceFeatureWidget(
      featureText: "Best Marketing Bot",
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
      featureText: "Best Marketing Bot",
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
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    final _textTheme = Theme.of(context).textTheme;
    return AbsorbPointer(
      absorbing: _isSubscribingStand ? _isSubscribingStand : _isSubscribingPrem,
      child: Scaffold(
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
                      backgroundColor:
                          Color(int.parse(widget.service.serviceColor[0])),
                      mini: true,
                      heroTag: widget.service.serviceIcon,
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(widget.service.serviceName,
                          style: _textTheme.headline1),
                      const Text("Campaign"),
                      const SizedBox(height: 20.0),
                      Text(
                        "With ${widget.service.serviceName} campaign you can now grow your business, market your brand or any organization with number of inbox messages, posts in multiple groups and much more!\n\nSo, subscribe to your favorite serivce and get started now!",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  StandardServiceSubscriptionCard(
                    subscribing: _isSubscribingStand,
                    serviceType: widget.service.serviceType[0],
                    colorTheme:
                        Color(int.parse(widget.service.serviceColor[0])),
                    iconData: widget.service.serviceIcon,
                    standardFeatures: _standardFeatures,
                    subcribe: _standardSubscription,
                  ),
                  widget.service.serviceName == "SMS Marketing" ||
                          widget.service.serviceName == "Email Marketing"
                      ? Container()
                      : const SizedBox(height: 40.0),
                  widget.service.serviceName == "SMS Marketing" ||
                          widget.service.serviceName == "Email Marketing"
                      ? Container()
                      : PremiumServiceSubscriptionCard(
                          subscribing: _isSubscribingPrem,
                          serviceType: widget.service.serviceType[1],
                          colorTheme:
                              Color(int.parse(widget.service.serviceColor[0])),
                          iconData: widget.service.serviceIcon,
                          standardFeatures: _premiumFeatures,
                          subcribe: _premiumSubscription,
                          // subcribe: _subscribe,
                        ),
                  const SizedBox(height: 20.0),
                  Divider(color: Colors.grey),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    btnWidth: 180.0,
                    btnHeight: 40.0,
                    btnOnPressed: () =>
                        _giveReviewAlertBox(_themeProvider.darkTheme),
                    btnColor: kPrimaryBlueColor,
                    btnText: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.edit, color: Colors.white),
                        const SizedBox(width: 8.0),
                        Text("Write a review", style: kBtnTextStyle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reviews",
                      style: _textTheme.headline1,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        widget.service.serviceRatings.toStringAsFixed(1),
                        style: _textTheme.headline1,
                      ),
                      Expanded(child: Container()),
                      for (int i = 0; i < 4; i++)
                        const Icon(Icons.star_rounded, size: 30.0),
                      const Icon(Icons.star_half_rounded, size: 30.0)
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  FutureBuilder(
                    future: ServiceController().getServices(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (widget.service.serviceComments.length != 0) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                Divider(color: Colors.grey),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (context, index) => FeedbackCard(
                                serviceCommentData:
                                    widget.service.serviceComments[index]),
                          );
                        } else {
                          return Center(
                            child: const Text("No Reviews Yet!"),
                          );
                        }
                      } else {
                        return Center(
                          child: JumpingDotsProgressIndicator(
                            fontSize: 40,
                            color: kPrimaryBlueColor,
                          ),
                        );
                      }
                    },
                  ),
                  TextButton(
                    onPressed: widget.service.serviceComments.length == 0
                        ? null
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserReviews(
                                  userReviews: widget.service.serviceComments,
                                ),
                              ),
                            ),
                    child: const Text(
                      "See all reviews",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showNotification() async {
    var android = AndroidNotificationDetails('id', 'channel ', 'description',
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('xperia'));
    var iOS = IOSNotificationDetails(
      sound: "xperia.mp3",
    );
    var platform = new NotificationDetails(
      android: android,
      iOS: iOS,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      widget.service.serviceName,
      "Service has been subscribed successfully!",
      platform,
      payload: 'xperia',
    );
  }

  void _standardSubscription() async {
    setState(() {
      _isSubscribingStand = true;
    });
    String sessionId = await StripeServer(
            serviceName: widget.service.serviceName,
            price: widget.service.serviceType[0].typePrice)
        .createCheckout();

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => StripePaymentCheckout(
                  sessionId: sessionId,
                ))).whenComplete(() {
      setState(() {
        _isSubscribingStand = false;
      });
    });

    if (result == 'success') {
      int code = await serviceController.subscribeService(
        widget.service.serviceId,
        false,
      );

      if (code == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: paymentSuccessful,
        ));
        showNotification();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: paymentCanceled,
      ));
    }
  }

  void _premiumSubscription() async {
    setState(() {
      _isSubscribingPrem = true;
    });
    String sessionId = await StripeServer(
      serviceName: widget.service.serviceName,
      price: widget.service.serviceType[1].typePrice,
    ).createCheckout();

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => StripePaymentCheckout(
                  sessionId: sessionId,
                ))).whenComplete(() {
      setState(() {
        _isSubscribingPrem = false;
      });
    });

    if (result == 'success') {
      int code = await serviceController.subscribeService(
        widget.service.serviceId,
        true,
      );

      if (code == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: paymentSuccessful,
        ));
        showNotification();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: paymentCanceled,
      ));
    }
  }

  void _giveReview() async {
    int result = await ServiceController().giveFeedBack(
      widget.service.serviceId,
      _ratings.toString(),
      _reviewController.text.trim(),
    );
    print(result);
    if (result == 200) {
      _reviewController.clear();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: kLightGreenColor,
          content: Row(
            children: [
              const Icon(
                Icons.check,
                color: Colors.white,
              ),
              const SizedBox(width: 8.0),
              const Text("Review submitted!"),
            ],
          ),
        ),
      );
      setState(() {});
    } else {
      _reviewController.clear();
      Navigator.of(context).pop();
      customSnackBar(context, Colors.red, Text("Something went wrong!"));
    }
  }

  void _giveReviewAlertBox(bool theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Write a Review",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline2.fontSize,
            color: Provider.of<ThemeProvider>(context).darkTheme
                ? Colors.white
                : kLightGreenColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              itemSize: 30.0,
              initialRating: 0,
              minRating: 1,
              maxRating: 5,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _ratings = rating;
                });
              },
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.89,
              child: TextFormField(
                maxLines: 5,
                controller: _reviewController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText:
                      "Tell others what do you think about this service...",
                  hintStyle: Theme.of(context).textTheme.caption,
                  fillColor: theme ? Colors.black12 : Colors.grey[100],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          CustomButton(
            btnWidth: 90,
            btnHeight: 40,
            btnOnPressed: () => Navigator.pop(context),
            btnColor: Colors.white,
            btnText: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          CustomButton(
            btnWidth: 90,
            btnHeight: 40,
            btnOnPressed: _giveReview,
            btnColor: kLightGreenColor,
            btnText: Text(
              "Submit",
              style: kBtnTextStyle,
            ),
          ),
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
    @required this.serviceType,
    @required List<ServiceFeatureWidget> standardFeatures,
    this.subcribe,
    this.subscribing,
  })  : _standardFeatures = standardFeatures,
        super(key: key);

  final ServiceType serviceType;
  final Color colorTheme;
  final String iconData;
  final List<ServiceFeatureWidget> _standardFeatures;
  final Function subcribe;
  final bool subscribing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      width: 275,
      height: 465,
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServiceSubscriptionTop(
            iconData: iconData,
            price: serviceType.typePrice.toString(),
          ),
          SizedBox(height: 15.0),
          Text(
            serviceType.typeDesc,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15.0),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _standardFeatures.length,
              itemBuilder: (context, index) => _standardFeatures[index],
            ),
          ),
          SizedBox(height: 15.0),
          CustomButton(
            btnWidth: MediaQuery.of(context).size.width,
            btnHeight: 40.0,
            btnOnPressed: subcribe,
            btnColor: kLightBlueColor,
            btnText: subscribing
                ? kLoaderWhite
                : Text(
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
    @required this.serviceType,
    @required this.iconData,
    this.subcribe,
    this.subscribing,
    @required List<ServiceFeatureWidget> standardFeatures,
  })  : _standardFeatures = standardFeatures,
        super(key: key);

  final ServiceType serviceType;
  final Color colorTheme;
  final String iconData;
  final List<ServiceFeatureWidget> _standardFeatures;
  final Function subcribe;
  final bool subscribing;
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
            price: serviceType.typePrice.toString(),
            isPremeium: true,
          ),
          SizedBox(height: 15.0),
          Text(
            serviceType.typeDesc,
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
            btnText: subscribing
                ? kLoaderWhite
                : Text(
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

  final String iconData;
  final bool isPremeium;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.network(
          iconData,
          height: 50.0,
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
                  // height: 20.0,
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
