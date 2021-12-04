import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl:
            "https://www.privacypolicies.com/live/65345e73-a1c6-46cd-aaea-a90f86f44c63",
      ),
    );
  }
}
