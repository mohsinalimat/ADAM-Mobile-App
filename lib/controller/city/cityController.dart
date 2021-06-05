import 'dart:convert';

import 'package:adam/model/city.dart';
import 'package:http/http.dart' as http;

class CityAPI {
  final String url =
      "https://parseapi.back4app.com/classes/Pakistancities_City";

  Future getCityNames() async {
    final response = await http.get(Uri.parse(url), headers: {
      "X-Parse-Application-Id": "3Wq0xNVkmbuJ82gAjBMBXUbudQhu1i1YwT0UzFcn",
      "X-Parse-REST-API-Key": "FtQAll4YKsCSJSU4jRDCh4vE7ZShjWZVzctxekRD"
    });

    if (response.statusCode == 200) {
      return CityList.fromJSON(
        json.decode(response.body),
      );
    } else {
      print(response.statusCode);
      throw Exception("Getting Cities failed!!");
    }
  }
}
