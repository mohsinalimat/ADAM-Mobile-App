import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  bool _enableNotifications = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
        children: [
          ListTile(
            leading: Icon(
              _enableNotifications
                  ? Icons.notifications_active_rounded
                  : Icons.notifications_off_rounded,
            ),
            title: Text("Recieve notifications"),
            trailing: Switch(
              value: _enableNotifications,
              onChanged: (value) {
                setState(() {
                  _enableNotifications = value;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.music,
            ),
            title: Text("Notifications tone"),
            trailing: Text("Default")
          ),
        ],
      ),
    );
  }
}
