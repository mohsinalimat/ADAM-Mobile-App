import 'dart:async';
import 'dart:convert';

import 'package:adam/model/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  // sign up
  Future<int> signUp(
      {String fullName,
      String email,
      String phone,
      String password,
      String dob,
      String gender,
      String city,
      String country}) async {
    String url = "https://adam-web-api.herokuapp.com/user/signup";

    http.Response response = await http.post(Uri.parse(url), body: {
      "cust_fullName": fullName,
      "cust_email": email,
      "cust_phone": phone,
      "cust_password": password,
      "cust_dob": dob,
      "cust_gender": gender,
      "cust_city": city,
      "cust_country": country,
      "isEmailVerified": true,
      "isPhoneVerified": true,
    });

    if (response.statusCode == 200) {
      // account created
      print("Account created!");
      return response.statusCode;
    } else if (response.statusCode == 204) {
      // already exists
      print("Account already exists!");
      return response.statusCode;
    }
    print("Undefined error!");
    return response.statusCode;
  }

  Future<int> login({String email, String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = "https://adam-web-api.herokuapp.com/user/login";

    http.Response response = await http.post(Uri.parse(url), body: {
      "cust_email": email,
      "cust_password": password,
    });

    if (response.statusCode == 200) {
      // login success
      // token & refreshToken
      Map json = jsonDecode(response.body);
      String jsonData = jsonEncode(UserData.fromJSON(json));
      prefs.setString("userData", jsonData);
      prefs.setString('token', json['token']);
      prefs.setString('userId', json['userId']);

      print(prefs.getString('token'));

      return response.statusCode;
    } else if (response.statusCode == 204) {
      print("User not found!");
      return response.statusCode;
    } else if (response.statusCode == 205) {
      print("Password mismatch!");
      return response.statusCode;
    } else if (response.statusCode == 401) {
      print("Token expire");
      return response.statusCode;
    }
    print("Some error!");
    return response.statusCode;
  }

  Future<int> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringfyJson = prefs.getString("userData");
    UserData userData;
    Map userDataObject = jsonDecode(stringfyJson);
    userData = UserData.fromJSON(userDataObject);

    String _token = userData.token;

    String url = "https://adam-web-api.herokuapp.com/user/logout";

    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": "Bearer $_token",
    });

    if (response.statusCode == 200) {
      // logout success
      // remove local data of user
      prefs.remove('userData');
      print("LOGOUT!");
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int> editProfile(String fullName, String email, String phone,
      String dob, String gender, String city, String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');

    String url = "https://adam-web-api.herokuapp.com/user/edit-profile";

    http.Response response = await http.post(Uri.parse(url), headers: {
      "Authorization": "Bearer $_token",
    }, body: {
      "userId": _userId,
      "cust_fullName": fullName,
      "cust_email": email,
      "cust_phone": phone,
      "cust_dob": dob,
      "cust_gender": gender,
      "cust_city": city,
      "cust_country": country,
    });

    if (response.statusCode == 200) {
      print("PROFILE UPDATED!");
      Map json = jsonDecode(response.body);
      String jsonData = jsonEncode(UserData.fromJSON(json));
      prefs.setString("userData", jsonData);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int> updateProfilePic(String photoUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');

    String url = "https://adam-web-api.herokuapp.com/user/upload-pic";

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $_token",
      },
      body: {
        "userId": _userId,
        "cust_photo": photoUrl,
      },
    );

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      String jsonData = jsonEncode(UserData.fromJSON(json));
      prefs.setString("userData", jsonData);
      print("DP UPLOADED $photoUrl");
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future forgotPassword(String email) async {
    String url = "https://adam-web-api.herokuapp.com/user/forgot-password";

    http.Response response = await http.post(Uri.parse(url), body: {
      "cust_email": email,
    });

    if (response.statusCode == 200) {
      print("Email found!");
      Map json = jsonDecode(response.body);
      return json['resetLink'];
    } else if (response.statusCode == 204) {
      print("Account does not exists with this email!");
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future changePassword(String pass, String confirmPass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');

    String url = "https://adam-web-api.herokuapp.com/user/update-password";

    var body = {
      'password': pass,
      'cPassword': confirmPass,
      'userId': _userId,
    };

    var headers = {
      'Authorization': "Bearer $_token",
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('pass updated!');
      return response.statusCode;
    } else {
      print('some error!');
      return response.statusCode;
    }
  }

  Future<int> deleteAccount(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');

    String url = "https://adam-web-api.herokuapp.com/user/delete-account";

    var body = {
      'password': password,
      'userId': _userId,
    };

    var headers = {
      'Authorization': "Bearer $_token",
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('account deleted!');
      return response.statusCode;
    } else if (response.statusCode == 204) {
      print('password mismatched!');
      return response.statusCode;
    } else {
      print('some error!');
      return response.statusCode;
    }
  }
}
