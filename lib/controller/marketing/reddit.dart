import 'package:adam/model/scraping/reddit/scraped_data.dart';
import 'package:dio/dio.dart';

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
      String url = "http://10.0.2.2:5050/reddit/scraper";
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
      String url = "http://10.0.2.2:5050/reddit/marketing";

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
  Future postText(String title, String bodyText) async {
    try {
      String url = "http://10.0.2.2:5050/reddit/post/text";
      var body = {
        "username": "m_hamzashakeel",
        "title": title,
        "text": bodyText,
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

  Future postImage(String title, String imagePathUrl) async {
    try {
      String url = "http://10.0.2.2:5050/reddit/post/image";
      var body = {
        "username": "m_hamzashakeel",
        "title": title,
        "image_path": imagePathUrl,
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

  Future postVideo(String title, String videoPathUrl) async {
    try {
      String url = "http://10.0.2.2:5050/reddit/post/video";
      var body = {
        "username": "m_hamzashakeel",
        "title": title,
        "video_path": videoPathUrl,
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
      String url = "http://10.0.2.2:5050/reddit/auto-reply";
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