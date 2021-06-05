import 'dart:convert';

import 'package:adam/model/country.dart';
import 'package:http/http.dart' as http;

class CountryAPI {
  final String url = "https://restcountries.herokuapp.com/api/v1";
  Future getCountryNames() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Data loaded!!");

      return CountryList.fromJSON(
        json.decode(response.body),
      );
    } else {
      print(response.statusCode);
      throw Exception("Getting countries failed!!");
    }
  }
}
