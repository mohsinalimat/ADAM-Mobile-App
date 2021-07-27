import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripePaymentCheckout extends StatefulWidget {
  final String sessionId;

  const StripePaymentCheckout({Key key, this.sessionId}) : super(key: key);
  @override
  _StripePaymentCheckoutState createState() => _StripePaymentCheckoutState();
}

class _StripePaymentCheckoutState extends State<StripePaymentCheckout> {
  WebViewController _webViewController;

  String get initialUrl =>
      "data:text/html;base64,${base64Encode(Utf8Encoder().convert(kStripeHTMLPage))}";

  static const String kStripeHTMLPage = '''
  <!DOCTYPE html>
  <html>
  <script src="https://js.stripe.com/v3/"></script>

  <head>
      <title>Stripe Checkout</title>
  </head>

  <body>
      <div style="position: absolute; text-align: center; width:100%; height:100%; top:50%;">
          <p>Loading Stripe...!</p>
      </div>
  </body>

  </html>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WebView(
          initialUrl: initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) =>
              _webViewController = webViewController,
          onPageFinished: (String url) {
            if (url == initialUrl) {
              _redirectToStripe(widget.sessionId);
            }
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://success.com')) {
              Navigator.of(context).pop("success");
            } else if (request.url.startsWith('https://cancel.com')) {
              Navigator.of(context).pop('cancel');
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }

  Future<void> _redirectToStripe(String sessionId) async {
    final redirectToCheckoutJs = '''
    var stripe = Stripe(\'${dotenv.env['apiKey']}\');
    
    stripe.redirectToCheckout({
      sessionId: '$sessionId'
    }).then(function (result) {
        result.error.message = 'Error'
    });
    ''';

    return await _webViewController.evaluateJavascript(redirectToCheckoutJs);
  }
}
