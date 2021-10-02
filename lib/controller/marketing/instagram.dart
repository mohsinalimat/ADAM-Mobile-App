import 'package:adam/model/scraping/instagram/scraped_user.dart';
import 'package:dio/dio.dart';

class InstagramMarketing {
  Future scrapeUserData() async {
    try {
      // String url = "http://40.76.15.56:5000/insta/scraper";
      String url = "http://10.0.2.2:8080/insta/scraper";

      var body = {
        "username": "testerbester01",
        "password": "tester123",
        "targeted_username": "bareera099",
      };
      var headers = {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      };

      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("GOT THE DATA!");
        return ScrapedUserList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future sendDM(String msg) async {
    try {
      String url = "http://10.0.2.2:8080/insta/marketing";
      var body = {
        "username": "testerbester01",
        "password": "tester123",
        "targeted_username": "bareera099",
        'marketing_msg': msg,
      };
      var headers = {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      };

      Dio dio = Dio();
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
        // return ScrapedUserList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
