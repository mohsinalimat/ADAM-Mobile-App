import 'package:adam/controller/darkModeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10.0, left: 15.0),
        children: [
          ListTile(
            leading: Icon(Icons.password),
            title: Text("Change password"),
            onTap: () => Navigator.pushNamed(context, '/changePassword'),
          ),
          ListTile(
            leading: Icon(Icons.disabled_by_default_rounded),
            title: Text("Disable account request"),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text(
              "Delete my account",
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.red[700],
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "Delete Account!",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.headline2.fontSize,
                          color: Provider.of<ThemeProvider>(context).darkTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  content: Text(
                    "You are about to delete your account. Please note that this process is irreversible and all your data will be lost!\n\nDo you want to continue?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/deleteAccount");
                      },
                      child: Text(
                        "Yes, I'm sure",
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("No, Cancel it"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
