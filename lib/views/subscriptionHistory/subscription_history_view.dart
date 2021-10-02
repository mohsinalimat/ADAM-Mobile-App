import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/widgets/subscriptionHistoryCard.dart';
import 'package:flutter/material.dart';

class SubscriptionHistoryView extends StatefulWidget {
  @override
  _SubscriptionHistoryViewState createState() =>
      _SubscriptionHistoryViewState();
}

class _SubscriptionHistoryViewState extends State<SubscriptionHistoryView> {
  final List<SubscriptionHistoryCard> cards = [
    SubscriptionHistoryCard(
      date: '12-10-2021',
      isPrem: true,
      serviceName: 'Instagram Marketing',
    ),
    SubscriptionHistoryCard(
      date: '01-11-2021',
      isPrem: true,
      serviceName: 'Twitter Marketing',
    ),
    SubscriptionHistoryCard(
      date: '12-01-2022',
      isPrem: false,
      serviceName: 'Email Marketing',
    ),
    SubscriptionHistoryCard(
      date: '12-08-2022',
      isPrem: false,
      serviceName: 'LinkedIn Marketing',
    ),
    SubscriptionHistoryCard(
      date: '11-02-2021',
      isPrem: true,
      serviceName: 'Instagram Marketing',
    ),
    SubscriptionHistoryCard(
      date: '18-07-2021',
      isPrem: false,
      serviceName: 'Twitter Marketing',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Subscription History",
                  style: _textTheme.headline1,
                ),
                SizedBox(height: 5.0),
                Text("We care about your subscription!"),
                const SizedBox(height: 25.0),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      if (cards.length == 0) {
                        return Center(
                          child: Text("No Subscriptions found!"),
                        );
                      }
                      return WidgetAnimator(
                        child: Dismissible(
                          key: UniqueKey(),
                          child: cards[index],
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              setState(() {
                                cards.removeAt(index);
                              });
                              customSnackBar(
                                  context,
                                  Colors.red[700],
                                  Row(
                                    children: [
                                      const Icon(Icons.delete_rounded,
                                          color: Colors.white),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        "${cards[index].serviceName} History Deleted!",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ));
                            }
                          },
                          background: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete_rounded,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
