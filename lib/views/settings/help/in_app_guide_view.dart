import 'package:adam/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class InAppGuideView extends StatefulWidget {
  @override
  _InAppGuideViewState createState() => _InAppGuideViewState();
}

class _InAppGuideViewState extends State<InAppGuideView> {
  final pages = [
    PageModel(
      color: kPrimaryBlueColor,
      imageAssetPath: 'assets/inapp/loginSignup.png',
      title: 'Get Registered!',
      body: "Create your account with very simple process to get started :)",
      doAnimateImage: true,
    ),
    PageModel(
      color: kMediumBlueColor,
      imageAssetPath: 'assets/inapp/chooseService.png',
      title: 'Marketing Campaigns',
      body:
          "Find the required service for your brand to get started in the process.",
      doAnimateImage: true,
    ),
    PageModel(
      color: kLightBlueColor,
      imageAssetPath: 'assets/inapp/plan.png',
      title: 'Subscription Plans',
      body: "Subscribed to the plan according to your budget and features",
      doAnimateImage: true,
    ),
    PageModel(
      color: kMediumGreenColor,
      imageAssetPath: 'assets/inapp/find.png',
      title: 'Your Subscribed Services',
      body: "You can find your subscribed services at home screen in slider",
      doAnimateImage: true,
    ),
    PageModel(
      color: kLightGreenColor,
      imageAssetPath: 'assets/inapp/working.png',
      title: 'ADAM Working Real-time',
      body:
          "See the real-time working of ADAM while scraping data and marketing.",
      doAnimateImage: true,
    ),
    PageModel(
      color: kPrimaryBlueColor,
      imageAssetPath: 'assets/inapp/account.png',
      title: 'Account Scheduler',
      body:
          "Uplift your business games by using the account scheduler to posts, give replies and much more.",
      doAnimateImage: true,
    ),
    PageModel(
      color: kMediumBlueColor,
      imageAssetPath: 'assets/inapp/manage.png',
      title: 'Manage Services',
      body:
          "Manage your services, favorites them, check your subscription history and more!",
      doAnimateImage: true,
    ),
    PageModel(
      color: kMediumGreenColor,
      imageAssetPath: 'assets/inapp/stats.png',
      title: 'Real Time Stats',
      body: "Check your business stats updating in real-time",
      doAnimateImage: true,
    ),
    PageModel(
      color: kLightBlueColor,
      imageAssetPath: 'assets/inapp/chat.png',
      title: 'Ask for Help!',
      body:
          "Live chat with ADAM team to clear out your queries and ask for any information",
      doAnimateImage: true,
    ),
    PageModel(
      color: Colors.black,
      imageAssetPath: 'assets/inapp/dark.png',
      title: 'Unique User Experience',
      body:
          "Experience a uniquely designed ADAM application, dark mode and other features :)",
      doAnimateImage: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        showBullets: true,
        pages: pages,
        finishCallback: () => Navigator.pop(context),
        skipCallback: () => Navigator.pop(context),
      ),
    );
  }
}
