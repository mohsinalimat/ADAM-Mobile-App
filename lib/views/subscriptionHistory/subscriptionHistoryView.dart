import 'package:adam/widgets/subscriptionHistoryCard.dart';
import 'package:flutter/material.dart';

class SubscriptionHistoryView extends StatelessWidget {
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
                  itemCount: 10,
                  itemBuilder: (context, index) => SubscriptionHistoryCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
