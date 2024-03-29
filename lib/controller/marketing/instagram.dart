import 'package:adam/constants.dart';
import 'package:adam/model/scraping/instagram/scraped_user.dart';
import 'package:dio/dio.dart';

class InstagramMarketing {
  static Dio dio = Dio();

  static var headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  static Future scrapeUserData(
      String userInsta, String passInsta, String targetUsername) async {
    try {
      String url = "$kAzureIP:8080/insta/scraper";

      var body = {
        "username": userInsta,
        "password": passInsta,
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
        return InstaScrapedUserList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  static Future sendDM(String msg, String username, String password,
      List<String> usernames) async {
    try {
      String url = "$kAzureIP:8080/insta/marketing";
      var body = {
        "username": 'khaadi.pk.7',
        "password": 'Test123@',
        'marketing_content': msg,
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

  // image post scheduler
  static Future postImageStatus(String username, String password,
      String caption, String imagePath) async {
    try {
      String url = "$kAzureIP:8080/insta/post/status/image";

      var body = {
        'username': username,
        'password': password,
        'image_path': imagePath,
        'caption': caption,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return 'status failed!';
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  static Future postVideoStatus(String username, String password,
      String caption, String videoPath) async {
    try {
      String url = "$kAzureIP:8080/insta/post/status/video";
      var body = {
        'username': username,
        'password': password,
        'video_path': videoPath,
        'caption': caption,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return 'status failed!';
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  // image story scheduler
  static Future postImageStory(
      String username, String password, String imagePath) async {
    try {
      String url = "$kAzureIP:8080/insta/post/story/image";
      var body = {
        'username': username,
        'password': password,
        'image_path': imagePath,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return 'Status failed!';
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  static Future postVideoStory(
      String username, String password, String videoPath) async {
    try {
      String url = "$kAzureIP:8080/insta/post/story/video";
      var body = {
        'username': username,
        'password': password,
        'video_path': videoPath,
      };

      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return 'Status failed!';
      }
    } on DioError catch (e) {
      return e.message;
    }
  }
}
