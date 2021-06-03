import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/views/services/serviceSubscriptionView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {Key key,
      @required this.serviceIcon,
      @required this.serviceName,
      @required this.serviceDescription,
      @required this.servicePrice,
      @required this.gradientColors,
      this.addFavorite,
      this.isFavorite = false})
      : super(key: key);

  final IconData serviceIcon;
  final String serviceName;
  final String serviceDescription;
  final String servicePrice;
  final List<Color> gradientColors;
  final Function addFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      height: _themeProvider.size == "Large"
          ? 240
          : _themeProvider.size == "Medium"
              ? 200
              : 190,
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
                  SizedBox(width: 5.0),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          serviceName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                Theme.of(context).textTheme.headline2.fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Campaign",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "4.7",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            for (int i = 0; i < 4; i++)
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15.0,
                              ),
                            Icon(
                              Icons.star_half,
                              color: Colors.yellow,
                              size: 15.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: addFavorite,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
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
                          fontSize:
                              Theme.of(context).textTheme.subtitle2.fontSize,
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
