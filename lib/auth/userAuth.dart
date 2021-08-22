import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  Future<int> login(String email, String password) async {
    String url = "https://adam-web-api.herokuapp.com/user/login";

    Map<String, dynamic> body = {
      "cust_email": email,
      "cust_password": password,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      // login success
      print(response.body);
      var decodedJson = jsonDecode(response.body);
      String _userId = decodedJson['userId'];
      preferences.setString("userId", _userId);
      print(preferences.getString("userId"));
      return response.statusCode;
    } else if (response.statusCode == 204) {
      // doesn't exists
      return response.statusCode;
    } else {
      return null;
    }
  }

  Future<int> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = "https://adam-web-api.herokuapp.com/user/logout";
    http.Response response = await http.post(Uri.parse(url), body: {});
    print(response.body);
    if (response.statusCode == 200) {
      // logout success
      prefs.remove('userId');
      return response.statusCode;
    } else {
      return null;
    }
  }

  Future<int> signUp(
      String firstName,
      String lastName,
      String email,
      String password,
      String phone,
      String dob,
      String gender,
      String city,
      String country) async {
    String url = "https://adam-web-api.herokuapp.com/user/signup";

    Map<String, dynamic> body = {
      "cust_firstName": firstName,
      "cust_lastName": lastName,
      "cust_email": email,
      "cust_password": password,
      "cust_phone": phone,
      "cust_dob": dob,
      "cust_gender": gender,
      "cust_city": city,
      "cust_country": country,
    };

    var response = await http.post(
      Uri.parse(url),
      body: body,
    );

    if (response.statusCode == 200) {
      // created success
      return response.statusCode;
    } else if (response.statusCode == 204) {
      // already exists
      return response.statusCode;
    } else {
      return null;
    }
  }
}
