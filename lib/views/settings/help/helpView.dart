import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10.0, left: 15.0),
        children: [
          ListTile(
            leading: Icon(Icons.question_answer_rounded),
            title: Text("FAQs"),
            onTap: () => Navigator.pushNamed(context, '/faq'),
          ),
          ListTile(
            leading: Icon(Icons.help_rounded),
            title: Text("In-app walkthrough guide"),
            subtitle: Text("In-app screens guide"),
          ),
          ListTile(
            leading: Icon(Icons.videocam_rounded),
            title: Text("Video guide"),
            subtitle: Text("YouTube video help"),
          ),
          ListTile(
            leading: Icon(Icons.report_rounded),
            title: Text("Report a problem"),
            subtitle: Text("Bug? Issues?"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.paperclip),
            title: Text("Privacy Policy"),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("App info"),
            subtitle: Text("Version"),
          ),
        ],
      ),
    );
  }
}
