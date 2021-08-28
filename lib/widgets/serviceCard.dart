import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/model/service.dart';
import 'package:adam/views/services/serviceSubscriptionView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard(
      {Key key, this.service, this.addFavorite, this.isFavorite = false})
      : super(key: key);

  final Service service;
  final Function addFavorite;
  final bool isFavorite;

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isFav = false;
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
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
              colors: [
                for (int i = 0; i < widget.service.serviceColor.length; i++)
                  Color(int.parse(widget.service.serviceColor[i]))
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.network(
                      widget.service.serviceIcon,
                      color: Colors.white,
                      height: 45.0,
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.service.serviceName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .fontSize,
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
                                widget.service.serviceRatings
                                    .toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              for (int i = 0; i < 4; i++)
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 15.0),
                              Icon(Icons.star_half,
                                  color: Colors.yellow, size: 15.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFav = !_isFav;
                        });
                        var snackBar = SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Row(children: [
                            Icon(
                                _isFav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: Colors.white),
                            const SizedBox(width: 8.0),
                            _isFav
                                ? const Text("Added to favorites!")
                                : const Text("Removed from favorites!"),
                          ]),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Icon(
                        _isFav
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.service.serviceType[0].typeDesc,
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
                          text: "\$${widget.service.serviceType[0].typePrice}/",
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
                    heroTag: widget.service.serviceIcon,
                    elevation: 1.0,
                    backgroundColor:
                        Color(int.parse(widget.service.serviceColor[0])),
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
                          service: widget.service,
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
      ),
    );
  }
}
