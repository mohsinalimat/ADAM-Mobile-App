import 'dart:typed_data';
import 'dart:ui';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:adam/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SubscriptionHistoryCard extends StatefulWidget {
  final String serviceName;
  final String date;
  final String sId;
  final bool isPrem;
  SubscriptionHistoryCard({
    @required this.sId,
    @required this.date,
    @required this.isPrem,
    @required this.serviceName,
    Key key,
  }) : super(key: key);

  @override
  _SubscriptionHistoryCardState createState() =>
      _SubscriptionHistoryCardState();
}

class _SubscriptionHistoryCardState extends State<SubscriptionHistoryCard> {
  Uint8List pngBytes;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final _themeProviders = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
      height: 115.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Diagonal(
                clipHeight: 20.0,
                axis: Axis.vertical,
                position: DiagonalPosition.TOP_RIGHT,
                child: Container(
                  height: 30.0,
                  width: 150,
                  color: widget.isPrem ? kLightGreenColor : kLightBlueColor,
                  child: Center(
                    child: Text(
                      widget.isPrem ? "Premium" : "Standard",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _viewHistory(context),
                child: const Text("View"),
              ),
            ],
          ),
          Text(
            widget.serviceName,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: _themeProviders.darkTheme ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 5.0),
          Text('Renew Subscription: ${widget.date}')
        ],
      ),
    );
  }

  void _viewHistory(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          final _theme = Provider.of<ThemeProvider>(context);
          return Screenshot(
            controller: screenshotController,
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(1),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ClipPath(
                      clipper: MovieTicketBothSidesClipper(),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              color: Colors.grey[100],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          size: 18,
                                          color: _theme.darkTheme
                                              ? Colors.black
                                              : kPrimaryBlueColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    _theme.darkTheme
                                        ? 'assets/logo/logoBlack.svg'
                                        : 'assets/logo/logoColor.svg',
                                    height: 40,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Center(
                                    child: Text(
                                      "Automated Digital Assitant in Marketing",
                                      style: TextStyle(
                                        color: _theme.darkTheme
                                            ? Colors.black
                                            : kPrimaryBlueColor,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "ID#${widget.sId}",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: _theme.darkTheme
                                          ? Colors.black
                                          : kPrimaryBlueColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "Service Name:",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: _theme.darkTheme
                                          ? Colors.black
                                          : kPrimaryBlueColor,
                                    ),
                                  ),
                                  Text(
                                    widget.serviceName,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: _theme.darkTheme
                                          ? Colors.black
                                          : kPrimaryBlueColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "Type:",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: _theme.darkTheme
                                          ? Colors.black
                                          : kPrimaryBlueColor,
                                    ),
                                  ),
                                  Text(
                                    widget.isPrem ? "Premium" : "Standard",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: _theme.darkTheme
                                          ? Colors.black
                                          : kPrimaryBlueColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "Date:",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: _theme.darkTheme
                                          ? Colors.black
                                          : kPrimaryBlueColor,
                                    ),
                                  ),
                                  Text(
                                    widget.date,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: _theme.darkTheme
                                          ? Colors.black
                                          : kPrimaryBlueColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "Time:",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: _theme.darkTheme
                                          ? Colors.black
                                          : kPrimaryBlueColor,
                                    ),
                                  ),
                                  Text(
                                    "02:54:10 PM",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: _theme.darkTheme
                                          ? Colors.black
                                          : kPrimaryBlueColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: _shareRecipt,
                                    child: Row(
                                      children: [
                                        Text("Share "),
                                        Icon(Icons.share, size: 17.0)
                                      ],
                                    )),
                                TextButton(
                                    onPressed: _saveRecipt,
                                    child: Row(
                                      children: [
                                        Text("Save "),
                                        Icon(Icons.save, size: 17.0)
                                      ],
                                    )),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              color: Colors.grey[100],
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Securely paid via',
                                      style: TextStyle(
                                        color: _theme.darkTheme
                                            ? Colors.black
                                            : kPrimaryBlueColor,
                                      ),
                                    ),
                                    Image.asset('assets/stripe.png',
                                        height: 28.0)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _shareRecipt() async {
    String _pathFull =
        "${(await getExternalStorageDirectory()).path}/adam-recipt.png";
    Navigator.pop(context);
    Share.shareFiles([_pathFull]);
  }

  void _saveRecipt() async {
    PermissionStatus serviceStatus = await Permission.storage.request();

    if (serviceStatus == PermissionStatus.granted) {
      String _pathFull =
          "${(await getExternalStorageDirectory()).path}/adam-recipt.png";
      await screenshotController.captureAndSave(
          "${(await getExternalStorageDirectory()).path}",
          pixelRatio: 2.5,
          fileName: "adam-recipt.png",
          delay: Duration(milliseconds: 150));

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Saved at $_pathFull"),
        ),
      );
    } else if (serviceStatus == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Permission Denied"),
          action: SnackBarAction(
            textColor: kLightBlueColor,
            onPressed: () {},
            label: "Dismiss",
          ),
        ),
      );
    }
  }
}
