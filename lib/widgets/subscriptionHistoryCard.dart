import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:adam/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'customBtn.dart';

class SubscriptionHistoryCard extends StatefulWidget {
  SubscriptionHistoryCard({
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
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("10-05-2021"),
                  const SizedBox(height: 8.0),
                  Text(
                    "Facebook Marketing Campaign",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 5.0),
                  Text("Standard")
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "\$ 89.00",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline2.fontSize -
                                1.5),
                  ),
                  const SizedBox(height: 5.0),
                  CustomButton(
                    btnWidth: 80,
                    btnHeight: 30.0,
                    btnOnPressed: () => _viewHistory(context),
                    btnColor: kPrimaryBlueColor,
                    btnText: Text(
                      "View",
                      style: kBtnTextStyle,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _viewHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Screenshot(
        controller: screenshotController,
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("SID # 394882039488"),
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.cancel_outlined))
            ],
          ),
          titleTextStyle: Theme.of(context).textTheme.headline2,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Subscription Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Service Name:",
                style: TextStyle(fontSize: 12.0),
              ),
              Text(
                "Facebook Marketing Campaign",
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Type:",
                style: TextStyle(fontSize: 12.0),
              ),
              Text(
                "Standard",
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Date:",
                style: TextStyle(fontSize: 12.0),
              ),
              Text(
                "10-05-2021",
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Time:",
                style: TextStyle(fontSize: 12.0),
              ),
              Text(
                "02:54:10 PM",
                style: TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 20.0),
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
                          Icon(Icons.download, size: 17.0)
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _shareRecipt() {
    Navigator.pop(context);
    Share.share(
      "SID # 394882039488\n\nService Name: Facebook Marketing Campaign\n\nDate: 10-05-2021\n\nTime: 02:54:10 PM\n\nType: Standard",
      subject: "Subscription History",
    );
  }

  void _saveRecipt() async {
    await screenshotController
        .captureAndSave("${(await getExternalStorageDirectory()).path}",
            pixelRatio: 2.5,
            fileName: "${DateTime.now().toString()}.png",
            delay: Duration(milliseconds: 150))
        .then((value) async {});
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Saved at ${(await getExternalStorageDirectory()).path}/${DateTime.now().toString()}.png"),
      ),
    );
  }
}
