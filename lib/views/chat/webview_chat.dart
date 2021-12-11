import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatWebView extends StatefulWidget {
  final String token;
  const ChatWebView({
    Key key,
    this.token,
  }) : super(key: key);

  @override
  State<ChatWebView> createState() => _ChatWebViewState();
}

class _ChatWebViewState extends State<ChatWebView> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live chat'),
      ),
      body: WebView(
        initialUrl: "https://adam-live-chat.herokuapp.com/${widget.token}",
      ),
    );
  }
}
