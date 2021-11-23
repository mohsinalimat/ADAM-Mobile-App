import 'package:adam/utils/main_imports.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                _themeProvider.notify
                    ? Icons.notifications_active_rounded
                    : Icons.notifications_off_rounded,
              ),
              title: Text("Recieve notifications"),
              trailing: Switch(
                value: _themeProvider.notify,
                onChanged: (value) => _themeProvider.notify = value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
