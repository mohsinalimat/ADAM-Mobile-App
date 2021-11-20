import 'package:adam/model/scraping/linkedin/scraped_data.dart';
import 'package:dio/dio.dart';

class LinkedInMarketing {
  Dio dio = Dio();

  var headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  Future scrapeUserData(
      String emailLinkedIn, String passwordLinkedIn, String keyword) async {
    try {
      // String url = "http://10.0.2.2:5050/linkedin/scraper";
      String url = "http://172.20.52.237:2020/linkedin/scraper";

      var body = {
        "email": emailLinkedIn,
        "password": passwordLinkedIn,
        "keyword": keyword,
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
        return LinkedInScrapedUserList.fromJSON(response.data);
      } else {
        return "Some error!";
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
