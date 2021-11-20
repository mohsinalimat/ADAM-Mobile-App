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
      // String url = "http://10.0.2.2:5000/insta/scraper";
      String url = "https://adam-web-api.herokuapp.com/instagram/check-target";

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
      // String url = "http://40.76.15.56:5000/insta/marketing";
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

  // image post scheduler
  Future postImageStatus(String username, String password, String caption,
      String imagePath) async {
    try {
      print('IMAGE SEND API!');
      // String url = "http://40.76.15.56:5000/insta/post/status/image";
      String url = "http://10.0.2.2:5000/insta/post/status/image";
  
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
      // String url = "http://40.76.15.56:5000/insta/post/status/video";
      String url = "http://10.0.2.2:5000/insta/post/status/video";
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
      // String url = "http://40.76.15.56:5000/insta/post/story/image";
      String url = "http://10.0.2.2:5000/insta/post/story/image";
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
      // String url = "http://40.76.15.56:5000/insta/post/story/video";
      String url = "http://10.0.2.2:5000/insta/post/story/video";
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
