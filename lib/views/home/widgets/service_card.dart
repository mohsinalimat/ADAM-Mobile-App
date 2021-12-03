import 'package:adam/controller/service_controller.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/model/service.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/views/services/service_subscription_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard({
    Key key,
    this.service,
    this.refreshFtn,
  }) : super(key: key);

  final Service service;
  final Function(bool) refreshFtn;

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isFav = false;

  void _getFavoriteOrNot() {
    // setState(() {
    //   _isFav = widget.service.isFavorite;
    // });
  }

  @override
  void initState() {
    _getFavoriteOrNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () async {
          var value = await Navigator.push(
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
              pageBuilder: (context, anime1, anime2) => ServiceSubscriptionView(
                service: widget.service,
              ),
            ),
          );
          if (value == null) {
            value = false;
          }
          if (value) {
            widget.refreshFtn(value);
          }
        },
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
                        onTap: () async {
                          setState(() {
                            _isFav = !_isFav;
                          });
                          if (_isFav) {
                            customSnackBar(
                              context,
                              Colors.pink,
                              Row(children: [
                                Icon(
                                  _isFav
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  "${widget.service.serviceName} added to favorites!",
                                  style: TextStyle(color: Colors.white),
                                )
                              ]),
                            );
                            int code = await ServiceController()
                                .addFavorite(widget.service.serviceId);
                            if (code != 200) {
                              customSnackBar(
                                context,
                                Colors.red,
                                Row(children: [
                                  const Icon(Icons.info, color: Colors.white),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    "Service already in favorites :)",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              );
                            }
                          } else {
                            customSnackBar(
                              context,
                              Colors.pink,
                              Row(children: [
                                Icon(
                                    _isFav
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: Colors.white),
                                const SizedBox(width: 8.0),
                                Text(
                                  "${widget.service.serviceName} removed from favorites!",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ]),
                            );
                            int code = await ServiceController()
                                .deleteFavorite(widget.service.serviceId);
                            if (code != 200) {
                              customSnackBar(
                                context,
                                Colors.red,
                                Row(children: [
                                  const Icon(Icons.info, color: Colors.white),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    "Unexpected error!",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              );
                            }
                          }
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
                            text:
                                "\$${widget.service.serviceType[0].typePrice}/",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .fontSize,
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
                      onPressed: () async {
                        var value = await Navigator.push(
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
                        );
                        print("value $value");
                        if (value == null) {
                          value = false;
                        }
                        if (value) {
                          widget.refreshFtn(value);
                        }
                      },
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
      ),
    );
  }
}
