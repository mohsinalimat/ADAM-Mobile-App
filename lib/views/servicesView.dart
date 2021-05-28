import 'package:adam/constants.dart';
import 'package:adam/views/serviceSubscriptionView.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicesView extends StatefulWidget {
  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final _searchController = TextEditingController();

  final _servicesIcons = [
    FontAwesomeIcons.facebookSquare,
    FontAwesomeIcons.twitter,
    FontAwesomeIcons.instagram,
    FontAwesomeIcons.linkedinIn,
    Icons.mail,
    Icons.sms,
  ];

  final _servicesName = [
    "Facebook Marketing",
    "Twitter Marketing",
    "Instagram Marketing",
    "LinkedIn Marketing",
    "Email Marketing",
    "SMS Marketing",
  ];

  final _servicesDesc = [
    "Facebook marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
    "Twitter marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
    "Instagram marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
    "LinkedIn marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
    "Email marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
    "SMS marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
  ];

  final _servicesPrice = [
    "89",
    "119",
    "120",
    "145",
    "170",
    "200",
  ];

  final _servicesColors = [
    [
      kMediumGreenColor,
      kLightGreenColor,
    ],
    [
      kMediumBlueColor,
      kLightBlueColor,
    ],
    [
      Color(0xfff6d371),
      Color(0xfff27a1d),
      Color(0xffcf2872),
      Color(0xff912eb9),
      Color(0xff4d58ce),
    ],
    [
      Color(0xff0073af),
      kLightBlueColor,
    ],
    [
      kLightGreenColor,
      kMediumGreenColor,
    ],
    [
      kMediumGreenColor,
      kMediumBlueColor,
    ],
  ];

  final _services = [
    ServiceCard(
      serviceIcon: FontAwesomeIcons.facebookSquare,
      serviceName: "Facebook Marketing",
      serviceDescription:
          "Facebook marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "119",
      gradientColors: [
        kMediumGreenColor,
        kLightGreenColor,
      ],
    ),
    ServiceCard(
      serviceIcon: FontAwesomeIcons.twitter,
      serviceName: "Twitter Marketing",
      serviceDescription:
          "Twitter marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "149",
      gradientColors: [
        kMediumBlueColor,
        kLightBlueColor,
      ],
    ),
    ServiceCard(
      serviceIcon: FontAwesomeIcons.instagram,
      serviceName: "Instagram Marketing",
      serviceDescription:
          "Instagram marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "139",
      gradientColors: [
        Color(0xfff6d371),
        Color(0xfff27a1d),
        Color(0xffcf2872),
        Color(0xff912eb9),
        Color(0xff4d58ce),
      ],
    ),
    ServiceCard(
      serviceIcon: FontAwesomeIcons.linkedinIn,
      serviceName: "LinkedIn Marketing",
      serviceDescription:
          "LinkedIn marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "99",
      gradientColors: [
        Color(0xff0073af),
        kLightBlueColor,
      ],
    ),
    ServiceCard(
      serviceIcon: Icons.mail,
      serviceName: "Email Marketing",
      serviceDescription:
          "Email marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "179",
      gradientColors: [
        kLightGreenColor,
        kMediumGreenColor,
      ],
    ),
    ServiceCard(
      serviceIcon: Icons.sms,
      serviceName: "SMS Marketing",
      serviceDescription:
          "SMS marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "169",
      gradientColors: [
        kMediumGreenColor,
        kMediumBlueColor,
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(
                    color: kPrimaryBlueColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40.0,
                      child: CustomTextField(
                        textEditingController: _searchController,
                        textInputAction: TextInputAction.search,
                        textInputType: TextInputType.text,
                        hintText: "Type Something...",
                        icon: Icons.search,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Find What You Want!",
                style: kHeadingStyle,
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                "Subscribe and get started right away!",
                style: TextStyle(
                  color: kPrimaryBlueColor,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _services.length,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.transparent,
                    height: 30.0,
                  ),
                  itemBuilder: (context, index) => _services[index],
                  // itemBuilder: (context, index) => ServiceCard(
                  //   serviceIcon: _servicesIcons[index],
                  //   serviceName: _servicesName[index],
                  //   serviceDescription: _servicesDesc[index],
                  //   servicePrice: _servicesPrice[index],
                  //   gradientColors: _servicesColors[index],
                  //   // addFavorite: () {},
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key key,
    @required this.serviceIcon,
    @required this.serviceName,
    @required this.serviceDescription,
    @required this.servicePrice,
    @required this.gradientColors,
    this.addFavorite,
  }) : super(key: key);

  final IconData serviceIcon;
  final String serviceName;
  final String serviceDescription;
  final String servicePrice;
  final List<Color> gradientColors;
  final Function addFavorite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    serviceIcon,
                    color: Colors.white,
                    size: 45.0,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          serviceName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Campaign",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: addFavorite,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              serviceDescription,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "\$$servicePrice/",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
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
                FloatingActionButton(
                  heroTag: serviceIcon.toString(),
                  elevation: 1.0,
                  backgroundColor: gradientColors[0],
                  onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      reverseTransitionDuration: Duration(seconds: 1),
                      transitionDuration: Duration(seconds: 1),
                      transitionsBuilder: (context, ani1, ani2, child) {
                        return FadeTransition(
                          opacity: ani1,
                          child: child,
                        );
                      },
                      pageBuilder: (context, anime1, anime2) =>
                          ServiceSubscriptionView(
                        serviceName: serviceName,
                        iconData: serviceIcon,
                        colorTheme: gradientColors[0],
                        serviceDesc:
                            "With Facebook marketing campaign you can now grow your business, market your brand or any organization with number of inbox messages, posts in multiple groups and much more!\n\nSo, subscribe to your favorite serivce and get started now!",
                      ),
                    ),
                  ),
                  mini: true,
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
