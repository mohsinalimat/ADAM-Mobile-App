import 'dart:convert';
import 'dart:io';

import 'package:adam/constants.dart';
import 'package:dio/dio.dart';

class StripeServer {
  final String serviceName;
  final int price;

  StripeServer({this.serviceName, this.price});

  Future<String> createCheckout() async {
    // final auth = "Basic " + base64Encode(utf8.encode(dotenv.env['secretKey']));
    final auth = 'Basic ' + base64Encode(utf8.encode('$secretKey:'));
    final body = {
      'payment_method_types': ['card'],
      'line_items': [
        {
          'amount': price,
          'quantity': 1,
        }
      ],
      'mode': 'payment',
      'success_url': 'https://success.com/{CHECKOUT_SESSION_ID}',
      'cancel_url': 'https://cancel.com/',
    };

    try {
      final result = await Dio().post(
        "https://api.stripe.com/v1/checkout/sessions",
        data: body,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: auth},
          contentType: "application/x-www-form-urlencoded",
        ),
      );
      // final result = await http.post(
      //     Uri.parse(
      //       "https://api.stripe.com/v1/checkout/sessions",
      //     ),
      //     body: body,
      //     headers: {
      //       "content-type": "application/x-www-form-urlencoded",
      //     });
      // print(result.body);
      return result.data['id'];
    } catch (e) {
      print(e.response);
      throw e;
    }
  }
}
