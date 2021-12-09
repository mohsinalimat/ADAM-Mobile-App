import 'package:adam/constants.dart';
import 'package:adam/model/scraping/reddit/scraped_user.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class RedditMarketing {
  static Dio dio = Dio(); // dio instance to avoid recreating it with every call

  // common header
  static var headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  // scraper & marketing
  static Future getUserData(String keyword) async {
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
        return RedditScrapedDataList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  static Future startMarketing(List<dynamic> redditDataList,
      String marketingContent, List<String> usernames) async {
    try {
      String url = "$kAzureIP:5050/reddit/marketing";

      // getting usernames from redditScrapedData list
      if (usernames.length == 0) {
        for (int i = 0; i < redditDataList.length; i++) {
          usernames.add(redditDataList[i].username);
        }
      }

      var body = {
        "marketing_content": marketingContent,
        "usernames_list": usernames,
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
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  // account schedule
  static Future postText(String title, String bodyText, String dateTime) async {
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

  static Future postImage(
      String title, String imagePathUrl, String dateTime) async {
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
      return e.message;
    }
  }

  static Future postVideo(
      String title, String videoPathUrl, String dateTime) async {
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
      return e.message;
    }
  }

  // auto reply
  static Future autoReply(String msg) async {
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
      return e.message;
    }
  }
}
