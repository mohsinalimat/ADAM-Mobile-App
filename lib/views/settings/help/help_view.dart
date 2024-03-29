import 'package:adam/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            onTap: () => Navigator.pushNamed(context, AppRoutes.faq),
          ),
          ListTile(
            leading: Icon(Icons.help_outline_outlined),
            title: Text("In-app walkthrough guide"),
            subtitle: Text("In-app screens guide"),
            onTap: () => Navigator.pushNamed(context, AppRoutes.inApp),
          ),
          ListTile(
            leading: Icon(Icons.videocam_outlined),
            title: Text("Video guide"),
            subtitle: Text("YouTube video help"),
            onTap: () => launch('https://youtu.be/V_MCvYb9AX0'),
          ),
          ListTile(
            leading: Icon(Icons.report_problem_rounded),
            title: Text("Report a problem"),
            subtitle: Text("Bug? Issues?"),
            onTap: () => Navigator.pushNamed(context, AppRoutes.reportProblem),
          ),
          ListTile(
            leading: Icon(Icons.info_outlined),
            title: Text("App info"),
            subtitle: Text("Version"),
            onTap: () => Navigator.pushNamed(context, AppRoutes.appInfo),
          ),
          ListTile(
            leading: Icon(Icons.attach_file_outlined),
            title: Text("Privacy Policy"),
            onTap: () => Navigator.pushNamed(context, AppRoutes.privacyPolicy),
          ),
        ],
      ),
    );
  }
}
