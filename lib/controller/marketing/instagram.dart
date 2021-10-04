import 'package:adam/model/scraping/instagram/scraped_user.dart';
import 'package:dio/dio.dart';

class InstagramMarketing {
  Dio dio = Dio();
  var headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };
  Future scrapeUserData(
      String userInsta, String passInsta, String targetUsername) async {
    try {
      // String url = "http://40.76.15.56:5000/insta/scraper";
      // String url = "http://10.0.2.2:5000/insta/scraper";
      String url = "https://adam-web-api.herokuapp.com/instagram/check-target";

      var body = {
        // "username": userInsta,
        // "password": passInsta,
        "targeted_username": targetUsername,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("GOT THE DATA!");
        return InstaScrapedUserList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future sendDM(String msg, String username, String password) async {
    try {
      String url = "http://10.0.2.2:5000/insta/marketing";
      var body = {
        "username": username,
        "password": password,
        "targeted_username": "bareera099",
        'marketing_msg': msg,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("SENT ALL MSGS!");
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // scheduler
  Future postUpdate(
      String username, String password, String caption, String media) async {
    try {
      String url = "http://40.76.15.56:5000/insta/post/status";
      var body = {
        'username': username,
        'password': password,
        'file_path': media,
        'caption': caption,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        print('posted a status!');
        return response.statusCode;
      } else {
        throw 'status failed!';
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // scheduler
  Future postStory(String username, String password, String media) async {
    try {
      String url = "http://40.76.15.56:5000/insta/post/story";
      var body = {
        'username': username,
        'password': password,
        'file_path': media,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      print(response.data);
      if (response.statusCode == 200) {
        print('posted a story!');
        return response.statusCode;
      } else {
        throw 'status failed!';
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
