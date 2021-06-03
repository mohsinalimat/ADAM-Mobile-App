import 'package:flutter/material.dart';

class StatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Stats & Analysis",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
