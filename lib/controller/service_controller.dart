import 'dart:convert';

import 'package:adam/model/service.dart';
import 'package:adam/model/subscription_history.dart';
import 'package:adam/model/userData.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceController {
  Future<int> subscribeService(String serviceId, bool isPremium) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');

    String url = "https://adam-web-api.herokuapp.com/user/subscribe-service";

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': "Bearer $_token",
      },
      body: {
        'userId': _userId,
        'serviceId': serviceId,
        'isPremium': isPremium.toString(),
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      print('subscribed!');
      return response.statusCode;
    } else if (response.statusCode == 204) {
      print('already subscribed!');
      return response.statusCode;
    } else {
      print('some error!');
      return response.statusCode;
    }
  }

  Future<int> unsubscribeService(String serviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');
    String url = "https://adam-web-api.herokuapp.com/user/unsub-service";

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': "Bearer $_token",
      },
      body: {
        'userId': _userId,
        'serviceId': serviceId,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      print('unsubscribed!');
      return response.statusCode;
    } else {
      print('some error!');
      return response.statusCode;
    }
  }

  Future getSubscribedServices() async {
    Dio dio = Dio();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');
    String url =
        "https://adam-web-api.herokuapp.com/user/view-subscribed-services";

    Response response = await dio.post(
      url,
      data: {
        "userId": _userId,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $_token",
        },
      ),
    );

    if (response.statusCode == 200) {
      print('services found!');
      return SubscribedServices.fromJson(response.data);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load services');
    }
  }

  Future getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    String url = "https://adam-web-api.herokuapp.com/user/services";

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $_token",
      },
    );

    if (response.statusCode == 200) {
      return ServicesList.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future giveFeedBack(String serviceId, String ratings, String comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // local data
    String _token = prefs.getString('token');
    String stringfyJson = prefs.getString("userData");
    UserData userData;

    Map userDataObject = jsonDecode(stringfyJson);
    userData = UserData.fromJSON(userDataObject); // userdata object

    String url = "https://adam-web-api.herokuapp.com/user/add-feedback";

    var body = {
      "userId": userData.userId,
      "cust_fullName": userData.fullName,
      "serviceId": serviceId,
      "user_rating": ratings,
      "comment": comment,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Authorization": "Bearer $_token",
      },
    );

    if (response.statusCode == 200) {
      print("FEEDBACK SUCCESS!");
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future viewFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // local data
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');
    String url = "https://adam-web-api.herokuapp.com/user/view-favorites";

    var body = {
      'userId': _userId,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Authorization": "Bearer $_token",
      },
    );
    if (response.statusCode == 200) {
      print("FAVORITES VIEW!");
      return ServicesList.fromJSON(jsonDecode(response.body));
    } else if (response.statusCode == 204) {
      return ServicesList.fromJSON({"services": []});
    } else {
      return response.statusCode;
    }
  }

  Future addFavorite(String serviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // local data
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');
    String url = "https://adam-web-api.herokuapp.com/user/add-favorite";

    var body = {
      'userId': _userId,
      'serviceId': serviceId,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Authorization": "Bearer $_token",
      },
    );

    if (response.statusCode == 200) {
      print("FAVORITE ADDED!");
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future deleteFavorite(String serviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // local data
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');
    String url = "https://adam-web-api.herokuapp.com/user/delete-favorite";

    var body = {
      'userId': _userId,
      'serviceId': serviceId,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Authorization": "Bearer $_token",
      },
    );

    if (response.statusCode == 200) {
      print("FAVORITE DELETED!");
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future viewSubscriptionHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // local data
    String _token = prefs.getString('token');
    String _userId = prefs.getString('userId');
    String url = "https://adam-web-api.herokuapp.com/user/subscription-history";

    var body = {
      'userId': _userId,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        'Authorization': "Bearer $_token",
      },
    );

    if (response.statusCode == 200) {
      return SubscriptionList.fromJson(jsonDecode(response.body));
    } else {
      return SubscriptionList.fromJson({'services': []});
    }
  }

  Future deleteSubscriptionHistoryService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      // local data
      String _token = prefs.getString('token');
      String _userId = prefs.getString('userId');
      String url = "https://adam-web-api.herokuapp.com/user/delete-all-history";

      var body = {
        'userId': _userId,
      };

      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Authorization': "Bearer $_token",
        },
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future reportAProblem(String subject, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      // local data
      String _token = prefs.getString('token');
      String url = "https://adam-web-api.herokuapp.com/user/report-problem";

      var body = {
        'subject': subject,
        'description': description,
      };

      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Authorization': "Bearer $_token",
        },
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
