import 'package:dio/dio.dart';

class EmailMarketing {
  Dio dio = Dio();
  Future emailFromCSV(List<String> emailsList, String subject, String emailBody,
      String brandName) async {
    try {
      String url = "https://adam-web-api.herokuapp.com/email/marketing-csv";
      var body = {
        "brand_name": brandName,
        "subject": subject,
        "email_body": emailBody,
        "email_list": emailsList,
      };

      Response response = await dio.post(
        url,
        data: body,
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  Future emailFromDataBank(
      String subject, String emailBody, String brandName) async {
    try {
      String url =
          "https://adam-web-api.herokuapp.com/email/marketing-data-bank";
      var body = {
        "brand_name": brandName,
        "subject": subject,
        "email_body": emailBody,
      };

      Response response = await dio.post(
        url,
        data: body,
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } on DioError catch (e) {
      return e.message;
    }
  }
}
