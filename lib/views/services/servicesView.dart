import 'package:adam/constants.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:adam/widgets/serviceCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicesView extends StatefulWidget {
  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final _searchController = TextEditingController();
  List<ServiceCard> _filterService = [];

  final _services = [
    ServiceCard(
      serviceIcon: FontAwesomeIcons.facebookSquare,
      serviceName: "Facebook Marketing",
      serviceDescription:
          "Facebook marketing campaign with numbers of likes, comments, inbox messages, account scheduling and much more!",
      servicePrice: "119",
      gradientColors: [
        Color(0xff3a5794),
        kMediumBlueColor,
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
        kSecondaryBlueColor,
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
                        onChangeFtn: (value) {
                          _filterService.clear();
                          if (value.isEmpty) {
                            setState(() {});
                            return;
                          }
                          setState(() {
                            _filterService = _services.where((element) {
                              return element.serviceName
                                  .toLowerCase()
                                  .contains(value.toLowerCase());
                            }).toList();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              _filterService.length == 0
                  ? SizedBox(
                      height: 30.0,
                    )
                  : Container(),
              _filterService.length == 0
                  ? Text(
                      "Find What You Want!",
                      style: kHeadingStyle,
                    )
                  : Container(),
              _filterService.length == 0
                  ? SizedBox(
                      height: 2.0,
                    )
                  : Container(),
              _filterService.length == 0
                  ? Text(
                      "Subscribe and get started right away!",
                      style: TextStyle(
                        color: kPrimaryBlueColor,
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: _filterService.length != 0
                    ? ListView.separated(
                        itemCount: _filterService?.length ?? 0,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.transparent,
                          height: 30.0,
                        ),
                        itemBuilder: (context, index) => _filterService[index],
                      )
                    : ListView.separated(
                        itemCount: _services.length,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.transparent,
                          height: 30.0,
                        ),
                        itemBuilder: (context, index) => _services[index],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
