import 'package:adam/constants.dart';
import 'package:adam/utils/main_imports.dart';
import 'package:flutter/material.dart';

class ScheduledPostCard extends StatelessWidget {
  final String caption;
  final String date;
  final String time;

  const ScheduledPostCard({
    Key key,
    this.caption = "Some caption here",
    this.date = "12-10-2022",
    this.time = "12:00 PM",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _themeProviders = Provider.of<ThemeProvider>(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/phoneVerify.gif'),
        ),
        title: Text(
          caption,
          style: TextStyle(
            color: _themeProviders.darkTheme ? Colors.white : kPrimaryBlueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("$date at $time"),
      ),
    );
  }
}
