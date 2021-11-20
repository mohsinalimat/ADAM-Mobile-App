import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/service_controller.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/utils/main_imports.dart';
import 'package:adam/widgets/subscriptionHistoryCard.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SubscriptionHistoryView extends StatefulWidget {
  @override
  _SubscriptionHistoryViewState createState() =>
      _SubscriptionHistoryViewState();
}

class _SubscriptionHistoryViewState extends State<SubscriptionHistoryView> {
  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                    InkWell(
                      onTap: _clearAllHistory,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          "Clear history",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  "Subscription History",
                  style: _textTheme.headline1,
                ),
                SizedBox(height: 5.0),
                Text("We care about your subscription!"),
                const SizedBox(height: 25.0),
                FutureBuilder(
                  future: ServiceController().viewSubscriptionHistory(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.subscriptions.length == 0) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Text('No History Found!'),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.subscriptions.length,
                        itemBuilder: (context, index) {
                          return WidgetAnimator(
                            child: SubscriptionHistoryCard(
                              sId: snapshot
                                  .data.subscriptions[index].subscriptionId,
                              date: "10-15-2020",
                              isPrem:
                                  snapshot.data.subscriptions[index].isPremium,
                              serviceName: snapshot
                                  .data.subscriptions[index].serviceName,
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Center(
                          child: JumpingDotsProgressIndicator(
                            fontSize: 30,
                            color: Provider.of<ThemeProvider>(context).darkTheme
                                ? Colors.white
                                : kPrimaryBlueColor,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearAllHistory() async {
    customSnackBar(
      context,
      Colors.red,
      Row(
        children: const [
          SizedBox(
            height: 20.0,
            width: 20.0,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            'Deleting History...',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );

    var value = await ServiceController().deleteSubscriptionHistoryService();
    setState(() {});

    if (value is String) {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8.0),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    } else {
      customSnackBar(
        context,
        kSecondaryBlueColor,
        Row(
          children: const [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 8.0),
            Text(
              'History has been deleted!',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    }
  }
}
