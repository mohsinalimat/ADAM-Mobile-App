import 'package:adam/model/scraping/instagram/scraped_user.dart';
import 'package:dio/dio.dart';

class LinkedInMarketing {
  Dio dio = Dio();
  var headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };
  Future scrapeUserData(String userLinkedIn, String passwordLinkedIn,
      String targetUsername) async {
    try {
      String url = "https://adam-web-api.herokuapp.com/instagram/check-target";

      var body = {
        // "username": userInsta,
        // "password": passInsta,
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
}
