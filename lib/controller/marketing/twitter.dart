import 'package:adam/constants.dart';
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
      String url = "http://13.72.68.224:3030/twitter/scraper";
      // String url = "http://40.76.15.56:8080/twitter/scraper";

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
      // String url = "http://40.76.15.56:8080/twitter/marketing";
      String url = "http://10.0.2.2:8080/twitter/marketing";

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
  Future tweetText(String caption, String dateTime) async {
    try {
      String url = "$kLocalHostIP:3030/twitter/schedule-tweet";
      var body = {
        'text': caption,
        'date': dateTime,
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

  // Tweet image
  Future tweetImage(String caption, String imagePath, String dateTime) async {
    try {
      if (caption.isEmpty) {
        caption = "";
      }
      String url = "$kLocalHostIP:3030/twitter/schedule-image";

      var body = {
        'text': caption,
        'image_path': imagePath,
        'date': dateTime,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("TWEETED IMAGE!");
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // Tweet video
  Future tweetVideo(String caption, String videoPath, String dateTime) async {
    try {
      if (caption.isEmpty) {
        caption = "";
      }
      String url = "$kLocalHostIP:3030/twitter/schedule-video";

      var body = {
        'text': caption,
        'video_path': videoPath,
        'date': dateTime,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("TWEETED VIDEO!");
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
      // String url = "http://40.76.15.56:8080/twitter/check-followers";
      String url = "http://10.0.2.2:8080/twitter/check-followers";

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
      // String url = "http://40.76.15.56:8080/twitter/greeting-dm";
      String url = "http://10.0.2.2:8080/twitter/greeting-dm";

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
  Future autoReply(String msg) async {
    try {
      // String url = "http://40.76.15.56:8080/twitter/auto-reply";
      String url = "http://10.0.2.2:8080/twitter/auto-reply";

      var body = {
        "reply_msg": msg,
      };

      Response response = await dio.post(
        url,
        data: body,
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
