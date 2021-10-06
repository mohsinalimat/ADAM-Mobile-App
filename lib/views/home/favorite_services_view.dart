import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/serviceController.dart';
import 'package:adam/model/service.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/utils/main_imports.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_indicators/progress_indicators.dart';

class FavoriteView extends StatefulWidget {
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  bool _favNotLoaded = true;
  List<Service> _favorites = [];

  void _gettingFavorites() async {
    ServicesList favs = await ServiceController().viewFavorite();
    setState(() {
      _favorites = List.from(favs.services);
      _favNotLoaded = false;
    });
    print(_favorites);
  }

  @override
  void initState() {
    _gettingFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    const LogoDisplay(),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Favorite Services",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 5.0),
                const Text("Keep an eye on your favorites!"),
                const SizedBox(height: 20.0),
                _favNotLoaded
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: JumpingDotsProgressIndicator(
                          fontSize: 40.0,
                          color: Provider.of<ThemeProvider>(context).darkTheme
                              ? Colors.white
                              : kPrimaryBlueColor,
                        ))
                    : _favorites.length == 0
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Center(
                              child: const Text("No favorite services found!"),
                            ),
                          )
                        : ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: _favorites
                                .map((fav) => WidgetAnimator(
                                      child: Dismissible(
                                        key: UniqueKey(),
                                        direction: DismissDirection.endToStart,
                                        child: FavoriteServiceCard(
                                          service: fav,
                                        ),
                                        onDismissed: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            setState(() {
                                              _favorites.remove(fav);
                                            });
                                            customSnackBar(
                                              context,
                                              Colors.pink,
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .favorite_border_rounded,
                                                      color: Colors.white),
                                                  const SizedBox(width: 8.0),
                                                  Text(
                                                    "${fav.serviceName} removed from favorites!",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            );
                                            await ServiceController()
                                                .deleteFavorite(fav.serviceId);
                                          }
                                        },
                                        background: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          color: Colors.red,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 30.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FavoriteServiceCard extends StatelessWidget {
  final Service service;

  const FavoriteServiceCard({Key key, this.service}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _themeProviders = Provider.of<ThemeProvider>(context);
    return Container(
        height: 160.0,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: _themeProviders.darkTheme ? Colors.grey[800] : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2.0),
                blurRadius: 8.0,
                spreadRadius: 8.0,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.network(
                  service.serviceIcon,
                  height: 30,
                  color: Color(int.parse(service.serviceColor[1])),
                ),
                const SizedBox(width: 8.0),
                Text(
                  service.serviceName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Color(int.parse(service.serviceColor[1])),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(service.serviceType[0].typeDesc),
            const SizedBox(height: 12.0),
            Text(
              "Starting at: \$ ${service.serviceType[0].typePrice}/month",
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Text("Ratings: ${service.serviceRatings}.0"),
                Spacer(),
                const Icon(
                  Icons.arrow_back,
                  color: Colors.red,
                ),
                const SizedBox(width: 5.0),
                const Text(
                  "Swipe to Remove",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ));
  }
}
