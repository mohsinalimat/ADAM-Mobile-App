import 'package:dio/dio.dart';

class InstagramMarketing {
  Future scrapeUserData() async {
    try {
      String url = "http://40.76.15.56:5000/insta/scraper";

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
      print(response.data);
      if (response.statusCode == 200) {
        print("GOT THE DATA!");
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
