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
      String url = "$kAzureIP:3030/twitter/scraper";

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
        return TwitterScrapedUserList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  // sending DMs
  Future sendDMs(String msg, List<String> usernames) async {
    try {
      String url = "$kAzureIP:3030/twitter/marketing";

      var body = {
        "msg": msg,
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
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
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
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
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
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  // greeting message to new followers
  Future checkNewFollowers() async {
    try {
      String url = "$kAzureIP:3030/twitter/check-followers";

      Response response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return TwitterScrapedUserList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  Future sendGreetingMsg(String msg) async {
    try {
      String url = "$kAzureIP:3030/twitter/greeting-dm";

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
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  // auto reply to mentions
  Future autoReply(String msg) async {
    try {
      String url = "$kAzureIP:3030/twitter/auto-reply";

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
        return response.statusCode;
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      return e.message;
    }
  }
}
