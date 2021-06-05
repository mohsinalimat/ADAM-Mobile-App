import 'package:flutter/material.dart';

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
            leading: Icon(Icons.question_answer_outlined),
            title: Text("FAQs"),
            onTap: () => Navigator.pushNamed(context, '/faq'),
          ),
          ListTile(
            leading: Icon(Icons.help_outline_outlined),
            title: Text("In-app walkthrough guide"),
            subtitle: Text("In-app screens guide"),
          ),
          ListTile(
            leading: Icon(Icons.videocam_outlined),
            title: Text("Video guide"),
            subtitle: Text("YouTube video help"),
          ),
          ListTile(
            leading: Icon(Icons.report_problem_rounded),
            title: Text("Report a problem"),
            subtitle: Text("Bug? Issues?"),
            onTap: () => Navigator.pushNamed(context, '/reportProblem'),
          ),
          ListTile(
            leading: Icon(Icons.info_outlined),
            title: Text("App info"),
            subtitle: Text("Version"),
            onTap: () => Navigator.pushNamed(context, '/appInfo'),
          ),
          ListTile(
            leading: Icon(Icons.attach_file_outlined),
            title: Text("Privacy Policy"),
          ),
        ],
      ),
    );
  }
}
