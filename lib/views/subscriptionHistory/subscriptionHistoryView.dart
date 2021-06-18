import 'package:adam/widgets/subscriptionHistoryCard.dart';
import 'package:flutter/material.dart';

class SubscriptionHistoryView extends StatefulWidget {
  @override
  _SubscriptionHistoryViewState createState() =>
      _SubscriptionHistoryViewState();
}

class _SubscriptionHistoryViewState extends State<SubscriptionHistoryView> {
  final List<SubscriptionHistoryCard> cards = [
    SubscriptionHistoryCard(),
    SubscriptionHistoryCard(),
    SubscriptionHistoryCard(),
    SubscriptionHistoryCard(),
    // SubscriptionHistoryCard(),
    // SubscriptionHistoryCard(),
    // SubscriptionHistoryCard(),
    // SubscriptionHistoryCard(),
    // SubscriptionHistoryCard(),
    // SubscriptionHistoryCard(),
  ];

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "Subscription History",
                      style: _textTheme.headline1,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
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
                      return Dismissible(
                        key: UniqueKey(),
                        child: cards[index],
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            setState(() {
                              cards.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red[700],
                              content: Row(
                                children: [
                                  const Icon(Icons.delete_rounded,
                                      color: Colors.white),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    "Deleted!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ));
                          }
                        },
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
