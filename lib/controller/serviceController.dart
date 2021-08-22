import 'dart:convert';

import 'package:adam/model/service.dart';
import 'package:http/http.dart' as http;

class ServiceController {
  Future<void> getServices() async {
    String url = "https://adam-web-api.herokuapp.com/user/services";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ServicesList.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Failed to load services');
    }
  }
}
