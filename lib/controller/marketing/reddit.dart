import 'package:adam/constants.dart';
import 'package:adam/model/scraping/reddit/scraped_data.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class RedditMarketing {
  Dio dio = Dio(); // dio instance to avoid recreating it with every call

  // common header
  var headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  // scraper & marketing
  Future getUserData(String keyword) async {
    try {
      String url = "$kAzureIP:5050/reddit/scraper";
      var body = {
        "topic": keyword,
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
        return RedditScrapedDataList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future startMarketing(
      List<dynamic> redditDataList, String marketingContent) async {
    try {
      String url = "$kAzureIP:5050/reddit/marketing";

      // getting usernames from redditScrapedData list
      List<String> _usernames = [];
      for (int i = 0; i < redditDataList.length; i++) {
        _usernames.add(redditDataList[i].username);
      }

      var body = {
        "marketing_content": marketingContent,
        "usernames_list": _usernames,
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
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // account schedule
  Future postText(String title, String bodyText, String dateTime) async {
    try {
      String url = "$kLocalHostIP:3030/reddit/schedule-text";

      var body = {
        "username": "m_hamzashakeel",
        "title": title,
        "text": bodyText,
        "date": dateTime,
      };

      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } catch (e) {
      return e.message;
    }
  }

  Future postImage(String title, String imagePathUrl, String dateTime) async {
    try {
      String url = "$kLocalHostIP:3030/reddit/schedule-image";
      var body = {
        "username": "m_hamzashakeel",
        "title": title,
        "image_path": imagePathUrl,
        "date": dateTime,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future postVideo(String title, String videoPathUrl, String dateTime) async {
    try {
      String url = "$kLocalHostIP:3030/reddit/schedule-video";
      var body = {
        "username": "m_hamzashakeel",
        "title": title,
        "video_path": videoPathUrl,
        "date": dateTime,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // auto reply
  Future autoReply(String msg) async {
    try {
      String url = "$kAzureIP:5050/reddit/auto-reply";
      var body = {
        "text_msg": msg,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
