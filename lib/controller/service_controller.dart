import 'dart:convert';

import 'package:adam/model/service/service.dart';
import 'package:adam/model/service/services_list.dart';
import 'package:adam/model/subscribed_services/subscribed_services_list.dart';
import 'package:adam/model/subscription_history.dart';
import 'package:adam/model/user.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceController {
  final _hiveBox = Hive.box('subscribedServices');

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
    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 204) {
      return response.statusCode;
    } else {
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
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future getSubscribedServices() async {
    Dio dio = Dio();
    try {
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
        List<dynamic> _subscribedServices = response.data['subscribedServices'];
        List<String> _stringIds = [];

        for (int i = 0; i < _subscribedServices.length; i++) {
          _stringIds
              .add(_subscribedServices[i]['serviceData']['_id'].toString());
        }

        // cache in Hive
        await _hiveBox.put(_userId, _subscribedServices);

        return SubscribedServices.fromJson(response.data);
      } else {
        return "Some error occured!";
      }
    } on DioError catch (e) {
      return e.message;
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
      List<Service> _services = [];
      List<dynamic> _campaigns = json.decode(response.body)['services'];

      for (int i = 0; i < _campaigns.length; i++) {
        _services.add(Service.fromJSON(_campaigns[i]));
      }

      await _hiveBox.put(
        'campaigns',
        _services,
      );

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
    User userData;

    Map userDataObject = jsonDecode(stringfyJson);
    userData = User.fromJSON(userDataObject); // userdata object

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
