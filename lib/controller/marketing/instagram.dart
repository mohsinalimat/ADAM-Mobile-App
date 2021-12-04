import 'package:adam/constants.dart';
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
      print(e.message);
      return e.message;
    }
  }

  Future sendDM(String msg, String username, String password,
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

  // image post scheduler
  Future postImageStatus(String username, String password, String caption,
      String imagePath) async {
    try {
      print('IMAGE SEND API!');
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
        print('posted an image status!');
        return response.statusCode;
      } else {
        throw 'status failed!';
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future postVideoStatus(String username, String password, String caption,
      String videoPath) async {
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
      print(response.data);
      if (response.statusCode == 200) {
        print('posted a video status!');
        return response.statusCode;
      } else {
        throw 'status failed!';
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // image story scheduler
  Future postImageStory(
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
      print(response.data);
      if (response.statusCode == 200) {
        print('posted an image story!');
        return response.statusCode;
      } else {
        throw 'status failed!';
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future postVideoStory(
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
      print(response.data);
      if (response.statusCode == 200) {
        print('posted a video story!');
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
