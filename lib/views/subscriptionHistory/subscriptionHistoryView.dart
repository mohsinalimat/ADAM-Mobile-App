import 'package:flutter/material.dart';

class SubscriptionHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Subscription History",
                  style: _textTheme.headline1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
