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
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("EMAIL SENT!");
        return response.statusCode;
      } else {
        print('some error!');
        return response.statusCode;
      }
    } on DioError catch (e) {
      print(e.message);
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
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("EMAIL SENT!");
        return response.statusCode;
      } else {
        print('some error!');
        return response.statusCode;
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
