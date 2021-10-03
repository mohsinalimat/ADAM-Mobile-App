import 'package:adam/model/scraping/twitter/scraped_user.dart';
import 'package:dio/dio.dart';

class TwitterMarketing {
  Dio dio = Dio(); // dio instance to avoid recreating it with every call

  // common header
  var headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  /// Marketing Methods
  // scraping data
  Future scrapeUserData(String targetUsername) async {
    try {
      String url = "http://40.76.15.56:8080/twitter/scraper";

      var body = {
        "target_username": targetUsername,
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
        return TwitterScrapedUserList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // sending DMs
  Future sendDMs(String msg) async {
    try {
      String url = "http://40.76.15.56:8080/twitter/marketing";

      var body = {
        "msg": msg,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("SENT MESSAGES!");
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  /// Account Scheduling
  // Tweet without Media
  Future tweetText(String caption) async {
    try {
      String url = "http://40.76.15.56:8080/twitter/post/text";
      var body = {
        'text': caption,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("TWEETED TEXT!");
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // TODO: Tweet with Media (FORMS-DATA LOGIC in Backend)
  Future tweetMedia(String caption, String mediaPath) async {
    try {
      if (caption.isEmpty) {
        caption = "*No caption Provided*";
      }
      String url = "http://40.76.15.56:8080/twitter/post/media";
      var body = {
        'text': caption,
        'media': mediaPath,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("TWEETED MEDIA!");
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // greeting message to new followers
  Future checkNewFollowers() async {
    try {
      String url = "http://40.76.15.56:8080/twitter/check-followers";

      Response response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("GREETING MSG HAS BEEN SENT!!");
        return TwitterScrapedUserList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future sendGreetingMsg(String msg) async {
    try {
      String url = "http://40.76.15.56:8080/twitter/greeting-dm";

      var body = {
        "greeting_msg": msg,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("GREETING MSG HAS BEEN SENT!!");
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // auto reply to mentions
  Future autoReply() async {
    try {
      String url = "http://40.76.15.56:8080/twitter/auto-reply";

      Response response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("AUTO REPLIED MENTIONS!");
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
